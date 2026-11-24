import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

enum TodoPriority {
  low,
  medium,
  high;

  String get label {
    switch (this) {
      case TodoPriority.low:
        return 'Low';
      case TodoPriority.medium:
        return 'Medium';
      case TodoPriority.high:
        return 'High';
    }
  }
}

@Freezed(fromJson: true, toJson: true)
sealed class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    @Default(false) bool isCompleted,
    @Default(TodoPriority.medium) TodoPriority priority,
    required DateTime lastModified,
  }) = _Todo;

  const Todo._();

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  factory Todo.fromDbMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      title: map['title'] as String,
      isCompleted: (map['isCompleted'] as int) == 1,
      priority: TodoPriority.values[map['priority'] as int],
      lastModified: DateTime.parse(map['lastModified'] as String),
    );
  }

  Map<String, dynamic> toDbMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
      'priority': priority.index,
      'lastModified': lastModified.toIso8601String(),
    };
  }
}
