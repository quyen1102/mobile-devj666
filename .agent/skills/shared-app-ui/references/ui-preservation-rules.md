# UI Style Preservation, Component Reuse & Customization Rules

This document outlines the strict rules and boundaries for developers and AI agents when inheriting or extending this codebase (`nf_base` package). The goal is to keep the UI layout, styling, and design system identical to the base, swapping only business logic and brand elements.

---

## 1. Core Principles

- **Visual Preservation**: The layout structure, adaptive look-and-feel (iOS/Android), typography, spacing, and custom component styles are inherited and must not be altered.
- **Component & Style Reuse**: Always leverage existing components in `lib/src/widgets/` and style configurations in [styles.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/styles.dart). Reusing these items ensures faster development cycles and absolute interface consistency.
- **Strict Shell & Configuration Preservation**: TabBar (navigation shell) and Settings (preferences screens and configurations) must be preserved in their current state. Only swap out underlying business logic or domain specific views.

---

## 2. Allowed Customizations (Modifiable)

To skin the app for a different product, you are permitted to modify only:

1. **Brand Primary Color**:
   - Modify **only** `brandSeedColor` inside `_makeDefaultTheme` in [theme.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/theme.dart).
   - The theme system will automatically propagate this color, harmonizing it with the custom palette.
2. **Branding & Identity Assets**:
   - App Name, bundle ID, package name in `pubspec.yaml` and native configuration files (`android/`, `ios/`).
   - App Launcher Icons and static logo assets in `assets/`.
3. **Screen Views Content**:
   - Swap models, providers, and state logic in `lib/src/model/`.
   - Update screen content or child widgets inside `lib/src/view/` while keeping overall page layouts consistent.

---

## 3. Strict Prohibitions (Read-Only UI)

To prevent visual regressions, the following rules are strictly enforced:

### A. Core Styles, Spacing & Colors
- **Do not modify** constants in [styles.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/styles.dart) (such as `Styles.cardBorderRadius`, `Styles.bodyPadding`, text size configurations).
- **Do not modify** the color palette files (e.g. `lichess_colors.dart` and `LichessCustomColors` class). Treat them as read-only constants.

### B. Shared Custom Widgets (Catalog Reuse)
- **Do not modify or bypass** components in `lib/src/widgets/` (e.g. `PlatformScaffold`, `PlatformAppBar`, `PlatformButton`). 
- When building new features, **always** compose them using these shared platform widgets instead of standard Flutter `Scaffold` or `CupertinoPageScaffold` to speed up UI building.

### C. Color Usage Constraint
- **Never hardcode hex values** for UI elements (such as `Color(0xFF...)` or `Colors.white`/`Colors.black`).
- Always use `Theme.of(context).colorScheme.*` or `context.lichessColors.*` to preserve Dark/Light mode responsiveness and color harmony.

### D. TabBar Shell & Settings Preservation
- **Do not modify** the structure, sliding transition behavior, navigation logic, or number of tabs in [tab_scaffold.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/tab_scaffold.dart). The 4-tab shell structure must remain unchanged.
- **Do not alter** the settings screens flow or general preferences structures (`lib/src/model/settings/` and `lib/src/view/settings/`). The settings layout and logic must remain exactly as inherited.

---

## 4. UI Quality Compliance Check
Before submitting changes, you must run:
```bash
flutter analyze
dart format lib/src
```
Ensure no UI/Style analyzer warnings or formatting regressions exist.
