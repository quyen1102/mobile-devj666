import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nf_base/src/db/database.dart';
import 'package:nf_base/src/db/secure_storage.dart';
import 'package:nf_base/src/model/todo/todo.dart';

final todoSyncTokenProvider = FutureProvider<String?>((ref) async {
  return await SecureStorage.instance.read(key: 'todo_sync_token');
});

final todoListProvider = AsyncNotifierProvider<TodoListNotifier, IList<Todo>>(
  TodoListNotifier.new,
  name: 'TodoListProvider',
);

class TodoListNotifier extends AsyncNotifier<IList<Todo>> {
  @override
  Future<IList<Todo>> build() async {
    final db = await ref.watch(databaseProvider.future);
    final List<Map<String, dynamic>> maps = await db.query(
      'todo',
      orderBy: 'lastModified DESC',
    );
    
    // Demonstrate secure storage token loading
    final syncToken = await ref.watch(todoSyncTokenProvider.future);
    if (syncToken == null) {
      await SecureStorage.instance.write(key: 'todo_sync_token', value: 'mock_session_token_12345');
    }

    return IList(maps.map(Todo.fromDbMap));
  }

  Future<void> addTodo(String title, TodoPriority priority) async {
    final newItem = Todo(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      priority: priority,
      lastModified: DateTime.now(),
    );

    // Keep UI responsive or load properly
    final currentList = state.value ?? const IList.empty();
    state = AsyncValue.data(currentList.insert(0, newItem));

    state = await AsyncValue.guard(() async {
      final db = await ref.read(databaseProvider.future);
      await db.insert('todo', newItem.toDbMap());
      return state.value!;
    });
  }

  Future<void> toggleTodo(String id) async {
    if (!state.hasValue) return;

    final list = state.value!;
    final index = list.indexWhere((item) => item.id == id);
    if (index == -1) return;

    final item = list[index];
    final updatedItem = item.copyWith(
      isCompleted: !item.isCompleted,
      lastModified: DateTime.now(),
    );

    // Optimistic UI update
    state = AsyncValue.data(list.map((t) => t.id == id ? updatedItem : t).toIList());

    state = await AsyncValue.guard(() async {
      final db = await ref.read(databaseProvider.future);
      await db.update(
        'todo',
        updatedItem.toDbMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
      return state.value!;
    });
  }

  Future<void> deleteTodo(String id) async {
    if (!state.hasValue) return;

    final list = state.value!;
    // Optimistic UI update
    state = AsyncValue.data(list.removeWhere((item) => item.id == id));

    state = await AsyncValue.guard(() async {
      final db = await ref.read(databaseProvider.future);
      await db.delete(
        'todo',
        where: 'id = ?',
        whereArgs: [id],
      );
      return state.value!;
    });
  }
}
