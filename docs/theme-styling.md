# Theme & Styling Guide

The Base App features a dual-design system that automatically adjusts UI styles based on the host platform (iOS uses Cupertino aesthetics, Android/Desktop uses Material 3).

## Directory Structure
- `lib/src/theme.dart`: Exposes the core `makeAppTheme` method which constructs a customized `ThemeData` instance.
- `lib/src/styles/styles.dart`: Contains visual guidelines, font sizes, margins, shapes, and opacity definitions.
- `lib/src/utils/color_palette.dart`: Exposes dynamic system colors (Material 3 Dynamic Colors support) and solid presets.

---

## Dynamic Theme Generation

Theme settings are loaded from `GeneralPreferences` (managed under `lib/src/model/settings/general_preferences.dart`).

```dart
ThemeData makeAppTheme(BuildContext context, GeneralPrefs generalPrefs) {
  // 1. Checks host platform (isIOS)
  // 2. Evaluates Brightness (System theme vs Light vs Dark forced mode)
  // 3. Builds either default themed or background-image translucent themed ThemeData.
}
```

### Background Presets
The app supports transparent surfaces overlaying a solid color background or background image. Translucent styling is applied using `withValues(alpha: baseSurfaceAlpha)` to color schemes.

---

## Platform Adaptive Styling

The project overrides many Material 3 defaults on iOS to emulate a native Cupertino look:

| Material Component | Cupertino Override Style (On iOS) |
|---|---|
| `splashFactory` | `NoSplash.splashFactory` (No Android ink ripples on iOS) |
| `appBarTheme` | Translucent background, `navTitleTextStyle` styling |
| `cardTheme` | Border radius matches native iOS list card curves |
| `listTileTheme` | Vertically centered tiles, native text sizes and margins |
| `dialogTheme` | Rounded corners (14dp), no shadows, mimicking iOS ActionSheets |

---

## Custom Theme Extensions

For colors or properties not defined inside the standard `ColorScheme`, the app uses a custom theme extension `CustomTheme`:

```dart
// Usage inside widgets:
final customTheme = Theme.of(context).extension<CustomTheme>() ?? _defaultTheme;
final rowColor = isEven ? customTheme.rowEven : customTheme.rowOdd;
```

---

## Typography

To match iOS typography:
- Letter-spacing on Cupertino text theme defaults to `-0.41`.
- `kCupertinoDefaultTextTheme` is injected to override default Roboto letter spacing on Apple devices.

## Best Practices
1. **Never hardcode hex colors** directly in view components. Use `Theme.of(context).colorScheme.primary` (or other semantically mapped colors).
2. **Support Dark Mode**: Ensure all custom layouts reference the correct context-dependent theme variables.
3. **Use custom extensions** instead of creating multiple global constants for row/container styling.
4. **Integration with Localization (i18n)**: Always pair dynamic styling changes with localization using `context.l10n` (declared in `lib/src/utils/l10n_context.dart`) to support both light/dark theme shifts and multiple languages seamlessly.

---

## Refactoring & Compliance Status

The core user interfaces have been fully audited and refactored to ensure strict adherence to styling and localization rules:

- **Onboarding Flow** (`onboarding_screen.dart`, `onboarding_pages_1.dart`, `onboarding_pages_2.dart`): Removed fallback forced dark wrapping, allowing pages to dynamically render under the active system theme (light/dark/custom background). All string literals have been moved to `.arb` locale dictionaries.
- **Main View Tabs** (`home_tab_screen.dart`, `history_tab_screen.dart`, `progress_tab_screen.dart`): Replaced direct color calls with theme color scheme tokens (such as `colorScheme.surfaceContainer` and `colorScheme.onSurfaceVariant`) to prevent visual glitches on custom image background themes and Sepia/Light modes. All user-visible strings are localized using `context.l10n`.
