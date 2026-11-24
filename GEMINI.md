# GEMINI.md

This file provides system guidance for Gemini coding agents interacting with this repository.

## Project Overview

**Lichess Mobile Base** (`nf_base` package) is a fork of the official lichess-mobile application. It acts as a shell base project for creating similar tab-based applications.
- **Flutter**: UI Framework (Cupertino/Material hybrid)
- **Riverpod 3.x**: State management
- **Freezed**: Data classes and JSON serialization
- **Stockfish**: Integrated via `multistockfish` package

---

## UI Style Preservation & Component Reuse Rules (CRITICAL)

When modifying this repository to swap logic or build new features, the layout and style of the original app must remain unchanged:

1. **Component & Style Reuse**: Always build interfaces quickly by reusing widgets in `lib/src/widgets/` and style presets in `lib/src/styles/styles.dart`. This ensures consistency and accelerates frontend development.
2. **TabBar & Settings Preservation**: The TabBar navigation shell ([tab_scaffold.dart]) and Settings flows/models (under `lib/src/view/settings/` and `lib/src/model/settings/`) are core structural elements and must be preserved exactly as inherited. Only swap the screen contents and business logic.
3. **Modifiable Branding (Primary Color)**:
   - To change the app color, modify **only** `brandSeedColor` inside `_makeDefaultTheme` in [theme.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/theme.dart).
   - Do not edit the neutral palette generation or custom extensions.
4. **Read-Only UI Styling**:
   - Do not modify spacing, padding, borders, or typography constants in [styles.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/styles.dart).
   - Do not modify or replace the core custom color sets in [lichess_colors.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/lichess_colors.dart).
5. **Use Shared Custom Widgets**:
   - All UI screens must utilize components from `lib/src/widgets/` (such as `PlatformScaffold`, `PlatformAppBar`). Raw Flutter `Scaffold`/`CupertinoPageScaffold` are forbidden.
6. **Adaptive Context & No Hardcoded Colors**:
   - Always query colors from the theme (e.g. `Theme.of(context).colorScheme.primary` or `context.lichessColors.cyan`). Hardcoding hex color strings or direct `Colors.*` references is prohibited.


---

## Development Setup

```bash
# Get dependencies
flutter pub get

# Generate code
dart run build_runner build

# Static analysis
flutter analyze

# Code formatting
dart format lib/src test
```

---

## Testing Strategy
- Always mock at the HTTP layer using `httpClientFactoryProvider` overrides rather than overriding Riverpod providers directly.
- Ensure all test assertions avoid key-based chessground query widgets (instead use helpers in `test/test_helpers.dart`).
