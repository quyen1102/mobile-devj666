# Phase 2: Data Models & Controller

## Overview
Status: pending
Priority: high

## Related Code Files
- [todo.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/model/todo/todo.dart)
- [todo_controller.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/model/todo/todo_controller.dart)

## Implementation Steps
1. Create a `Todo` class using `freezed` with fields: `id`, `title`, `isCompleted`, `priority` (enum), and `lastModified`.
2. Implement `TodoController` extending `AsyncNotifier<IList<Todo>>`.
3. Read stored sync token/encryption key from `SecureStorage.instance` on startup to verify secure credential storage.
4. Implement `addTodo`, `toggleTodo`, `deleteTodo` using `AsyncValue.guard`.

## Todo List
- [ ] Implement `todo.dart` freezed data model
- [ ] Implement `todo_controller.dart` AsyncNotifier
- [ ] Query SQLite inside `TodoController.build()`
- [ ] Add mutations using `AsyncValue.guard`
