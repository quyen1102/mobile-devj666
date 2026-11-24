---
name: shared-app-ui
description: UI/design rules for Flutter apps on shared mobile base (nf_base). Use when building views, widgets, themes, navigation, swapping business logic. Platform-adaptive iOS/Android, colors, state patterns.
version: 1.0.0
---

# Shared App UI — Design & Interface Rules

This base app (`nf_base` package) provides a unified design system and structural shell. New applications inheriting this base must preserve the existing UI/UX elements, styling, and navigation scaffolding, replacing only the business logic.

## Core Principle

> **Visual Preservation & Component Reuse**: The layout structure, adaptive look-and-feel (iOS/Android), typography, spacing, TabBar, Settings, and custom component styles are inherited and must not be altered. Developers should reuse existing components and styles for fast and consistent UI development.

## Key Files

| Concern | File |
|---|---|
| Theme | `lib/src/theme.dart` → `makeAppTheme()` |
| Colors | `lib/src/styles/lichess_colors.dart`, `lib/src/styles/styles.dart` |
| Navigation shell | `lib/src/tab_scaffold.dart` |
| Platform widgets | `lib/src/widgets/platform.dart` |
| Reusable widgets | `lib/src/widgets/` |
| Settings state | `lib/src/model/settings/general_preferences.dart` |

## Quick Rules

1. **Never hardcode colors** — use `Theme.of(context).colorScheme.*` or `context.lichessColors.*`
2. **Always support dark mode** — use theme-aware colors only
3. **Platform-adaptive** — detect `Theme.of(context).platform == TargetPlatform.iOS` for Cupertino/Material splits
4. **Use `PlatformScaffold` / `PlatformAppBar`** for screens inside tab navigator
5. **Reuse Existing Components**: Build UIs quickly by composing widgets from `lib/src/widgets/` and styles from `lib/src/styles/styles.dart` to maintain consistency.
6. **Preserve Shell & Settings**: The core configurations for the TabBar ([tab_scaffold.dart]) and Settings flow (general preferences) must remain unchanged. Only swap screen business logic.
7. **Run `flutter analyze` + `dart format`** after every file edit

## References

- [Theme & Color System](references/theme-color-system.md)
- [UI Preservation & Customization Rules](references/ui-preservation-rules.md)
- [Navigation & Tab Shell](references/navigation-tab-shell.md)
- [Widget Catalog](references/widget-catalog.md)
- [State Management Patterns](references/state-patterns.md)
- [Adding a New Feature View](references/adding-new-feature-view.md)
