# AI Agent Rebrand & Bootstrap Prompt

This document contains a pre-configured prompt that you can copy and paste to any AI assistant (like Claude, Gemini, or ChatGPT) when you first initialize a new project using this repository as a base.

---

## Copy & Paste Prompt for AI Agents

```markdown
You are a senior Flutter developer tasked with converting/rebranding this base application (nf_base package) into a new application with different business logic.

Before you make any changes, you must fully understand the architecture and strict preservation rules of this codebase:

### 1. Codebase Context
- Framework: Flutter with Riverpod 3.x and Freezed (code generation).
- Structure:
  - `lib/src/widgets/` -> Shared adaptive platform components (PlatformScaffold, PlatformAppBar, etc.).
  - `lib/src/styles/` -> App styles, typography presets, custom theme extensions.
  - `lib/src/theme.dart` -> Master theme config (Material 3 + Cupertino adaptive).
  - `lib/src/tab_scaffold.dart` -> Core 4-tab shell and sliding transition navigation.
  - `lib/src/model/settings/` & `lib/src/view/settings/` -> Standard preferences structures.

### 2. Strict UI Style & Component Preservation Rules
You must strictly maintain the visual identity and layout of the original app:
- **Reuse Existing Components**: Build all new UI views by composing widgets from `lib/src/widgets/` and presets from `lib/src/styles/styles.dart`. Do not use raw Flutter Scaffold or CupertinoPageScaffold.
- **Preserve Shell & Settings**: Do not modify the structure or navigation of `lib/src/tab_scaffold.dart` (4-tab model) or the settings flow. Keep them intact.
- **Brand Color Modification**: To change the app's theme color, modify ONLY `brandSeedColor` in `_makeDefaultTheme` inside `lib/src/theme.dart`.
- **No Hardcoded Colors**: Always read colors from the theme context (`Theme.of(context).colorScheme.*` or `context.lichessColors.*`) to preserve Dark/Light mode.
- **Do not modify** base styles in `styles.dart` or custom colors in `lichess_colors.dart`.

### 3. Rebranding Objective
We are building a new application called: [INSERT NEW APP NAME]
Description of the new app's business logic: [INSERT BUSINESS LOGIC OR FEATURE DETAILS]

Please perform the following bootstrap steps sequentially:
1. Update `name` in `pubspec.yaml` to match the new package name and run a global search-and-replace to update all import paths from `package:nf_base/...` to `package:[new_package_name]/...`.
2. Locate Lichess-specific features under `lib/src/model/` (such as engine, challenge, puzzle, game) and clean/delete them.
3. Clean the corresponding views under `lib/src/view/`.
4. Create the new target view classes for the 4 navigation tabs.
5. Edit `lib/src/tab_scaffold.dart` to mount your new views onto the 4 tabs.
6. Run `flutter pub get` and `dart run build_runner build` to regenerate serializers and state.
7. Run `flutter analyze` and `dart format` to ensure clean static analysis.

Do you understand the codebase rules and the rebranding objective? If yes, please outline the exact files you will modify and delete to perform the clean start.
```
