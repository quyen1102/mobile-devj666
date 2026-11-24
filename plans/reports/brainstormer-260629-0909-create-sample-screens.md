# Brainstorming Report: Sample Screens for Base App Architecture

Brainstorming options for implementing sample screens in the base app to demonstrate compliance with key architectural guidelines (theme, coding style, database, state management).

## Problem Statement & Objectives
The goal is to design a sample feature with functional screens that serve as a reference implementation for future development. It must strictly conform to:
1. **`theme-styling.md`**: Dual-design system (Material 3/Cupertino), context-dependent theme colors, zero hardcoded hexes, support for forced dark mode, and localized strings (`context.l10n`).
2. **`coding_style.md`**: Immutability (via `freezed`), fast immutable collections (`IList`/`IMap`), strong typing, functional UI composition (`collection if`/`for`), and widgets-as-classes.
3. **`database-storage.md`**: SQLite schema migrations, TTL auto-pruning, and `SecureStorage` for secrets.
4. **`state-management.md`**: Riverpod 3.x with class-based notifiers (`Notifier` / `AsyncNotifier`), code generation, and UI consumption using `ConsumerWidget`/`ConsumerStatefulWidget`.

---

## Evaluated Options

### Option 1: Offline-First Notes & Sync Manager (Recommended)
A feature where users can manage notes locally with custom labels, backed by a secure encryption key / sync token.
- **SQLite Database**: Table `notes` (id, title, content, labels, isSynced, lastModified). Schema migration version 6.
- **Secure Storage**: Storage of a local encryption key or remote Sync Token using `SecureStorage.instance`.
- **State Management**: `AsyncNotifier` (for loading, adding, deleting, and updating notes) and `Notifier` (for search/filtering).
- **UI Screens**:
  - `NoteListScreen`: Shows notes using adaptive `PlatformScaffold`, search bar, and card layouts.
  - `NoteEditScreen`: Editor view with dynamic themes, inputs, and validators.
- **Pros**: Demonstrates every single guideline (database transactions, migrations, secure storage, immutable collections in data models, dynamic theme values, custom font sizes, class-based notifiers).
- **Cons**: Requires database table migration and a bit more code structure.

### Option 2: Personal Profile Customizer
A profile editor demonstrating account details, custom styling preferences, and security settings.
- **SQLite Database**: Table `app_log` check and a local `profile_logs` history table.
- **Secure Storage**: Storage of personal API tokens or secure passwords.
- **State Management**: `AsyncNotifier` representing account profiles.
- **UI Screens**:
  - `ProfileViewScreen`: Displays user details and statistics.
  - `ProfileEditScreen`: Input forms with custom fields.
- **Pros**: Simpler than notes, direct API integrations can be mocked easily.
- **Cons**: Lacks heavy query patterns and doesn't showcase SQLite storage capabilities well.

### Option 3: Quick Task / Todo Manager
A traditional todo list application.
- **SQLite Database**: Table `todos` (id, task, isCompleted, priority, lastModified).
- **Secure Storage**: Storage of user credentials or access tokens.
- **State Management**: `AsyncNotifier` representing list of todos.
- **Pros**: Extremely familiar and minimal.
- **Cons**: Might feel generic and doesn't showcase complex data relationships or rich UI customizability as well as Option 1.

---

## Final Recommended Solution: Option 1 (Offline-First Notes & Sync Manager)
We recommend Option 1 because it provides a complete, robust, and production-grade template for all future features in `nf_base`.

### Key Verification & Validation Criteria:
- Code generation compiles cleanly.
- `flutter analyze` runs without errors.
- Both iOS (Cupertino emulation) and Android (Material 3) rendering look correct.
- Schema migration from DB version 5 to 6 succeeds on existing installations.
