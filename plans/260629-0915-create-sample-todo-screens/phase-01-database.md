# Phase 1: Database Migration

## Overview
Status: pending
Priority: high

## Related Code Files
- [database.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/db/database.dart)

## Implementation Steps
1. Increment database version from 5 to 6 in `openAppDatabase`.
2. Define `_createTodoTableV6(Batch batch)` to execute the DDL query for creating the `todo` table.
3. Call `_createTodoTableV6(batch)` in `onCreate` and inside `onUpgrade` for `oldVersion < 6`.

## Todo List
- [ ] Increment database version to 6
- [ ] Add `_createTodoTableV6` function
- [ ] Add migration logic in `onCreate` and `onUpgrade`
