import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:nf_base/src/model/todo/todo.dart';
import 'package:nf_base/src/model/todo/todo_controller.dart';
import 'package:nf_base/src/utils/navigation.dart';
import 'package:nf_base/src/widgets/platform.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  static Route<dynamic> buildRoute() {
    return buildScreenRoute(screen: const TodoScreen());
  }

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final _textController = TextEditingController();
  TodoPriority _selectedPriority = TodoPriority.medium;
  String _filter = 'all';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todosAsync = ref.watch(todoListProvider);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Quick Tasks'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildInputSection(context),
            _buildFilterChips(context),
            Expanded(
              child: todosAsync.when(
                data: (todos) => _buildTodoList(context, todos),
                loading: () => const Center(child: CircularProgressIndicator.adaptive()),
                error: (error, _) => Center(
                  child: Text('Failed to load tasks: $error'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: 'Add a new task...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _addNewTodo,
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Priority:',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Row(
                children: TodoPriority.values.map((p) {
                  final isSelected = _selectedPriority == p;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(p.label),
                      selected: isSelected,
                      onSelected: (_) => setState(() => _selectedPriority = p),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: ['all', 'active', 'completed'].map((f) {
          final isSelected = _filter == f;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
            child: ChoiceChip(
              label: Text(f.toUpperCase()),
              selected: isSelected,
              onSelected: (_) => setState(() => _filter = f),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTodoList(BuildContext context, IList<Todo> todos) {
    final filtered = todos.where((t) {
      if (_filter == 'active') return !t.isCompleted;
      if (_filter == 'completed') return t.isCompleted;
      return true;
    }).toList();

    if (filtered.isEmpty) {
      return const Center(child: Text('No tasks found.'));
    }

    return ListView.builder(
      itemCount: filtered.length,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        final todo = filtered[index];
        return _TodoItemTile(todo: todo);
      },
    );
  }

  void _addNewTodo() {
    final title = _textController.text.trim();
    if (title.isNotEmpty) {
      ref.read(todoListProvider.notifier).addTodo(title, _selectedPriority);
      _textController.clear();
      FocusScope.of(context).unfocus();
    }
  }
}

class _TodoItemTile extends ConsumerWidget {
  const _TodoItemTile({required this.todo});

  final Todo todo;

  Color _priorityColor(BuildContext context, TodoPriority priority) {
    final colors = Theme.of(context).colorScheme;
    switch (priority) {
      case TodoPriority.high:
        return colors.error;
      case TodoPriority.medium:
        return colors.secondary;
      case TodoPriority.low:
        return colors.outline;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => ref.read(todoListProvider.notifier).toggleTodo(todo.id),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: todo.isCompleted ? theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6) : null,
          ),
        ),
        subtitle: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _priorityColor(context, todo.priority),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              todo.priority.label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () => ref.read(todoListProvider.notifier).deleteTodo(todo.id),
        ),
      ),
    );
  }
}
