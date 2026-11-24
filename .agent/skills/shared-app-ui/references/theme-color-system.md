# Theme & Color System

## Theme Entry Point

`makeAppTheme(BuildContext context, GeneralPrefs generalPrefs)` in `lib/src/theme.dart`
- Reads brightness from `generalPrefs.themeMode` (light/dark/system)
- Supports background color & background image with translucent surfaces
- Returns platform-specific `ThemeData` via `_makeDefaultTheme()` or `_makeBackgroundImageTheme()`

## Color Architecture

### Brand Colors (`lib/src/styles/lichess_colors.dart`)

| Token | Value | Use |
|---|---|---|
| `LichessColors.primary` | `#1B78D0` (blue) | Brand primary |
| `LichessColors.secondary` | `#629924` (green) | Win / positive |
| `LichessColors.accent` | `#D64F00` (orange) | Accent / CTA |
| `LichessColors.error` / `red` | `#CC3333` | Errors |
| `LichessColors.brag` | `#BF811D` gold | Achievements |
| `LichessColors.fancy` | `#B72FC6` pink | Decorative |
| `LichessColors.cyan` | `#56B4E9` | Info / stat |
| `LichessColors.purple` | `#8572ff` | Decorative |

### Custom Theme Extension (`lib/src/styles/styles.dart`)

```dart
// Access semantic custom colors anywhere:
final lichessColors = context.lichessColors; // LichessCustomColors
lichessColors.good    // win/positive
lichessColors.error   // loss/negative
lichessColors.brag    // gold/achievement
lichessColors.cyan    // info/stat
lichessColors.fancy   // premium/decorative
lichessColors.purple  // decorative
lichessColors.primary // brand blue
```

All are harmonized with the system `ColorScheme.primary` via `harmonizeWith()`.

### Row Alternating Colors

```dart
final customTheme = context.customTheme; // CustomTheme
color: isEven ? customTheme.rowEven : customTheme.rowOdd,
```

## Typography Tokens (`lib/src/styles/styles.dart`)

```dart
Styles.title            // fontSize 20, bold
Styles.subtitle         // fontSize 16, w500
Styles.callout          // fontSize 18, w600
Styles.sectionTitle     // fontSize 18, bold
Styles.mainListTileTitle // fontSize 18, w500
Styles.bold             // fontWeight bold
Styles.formLabel        // fontWeight bold
Styles.formError        // color: LichessColors.red
Styles.noResultTextStyle // grey, fontSize 20
Styles.subtitleOpacity   // 0.7 — apply to subtitle text colors
```

iOS uses Cupertino letter spacing (`-0.41`) via `kCupertinoDefaultTextTheme`.

## Spacing Constants

```dart
Styles.bodyPadding           // symmetric(16, 16)
Styles.horizontalBodyPadding // symmetric(horizontal: 16)
Styles.verticalBodyPadding   // symmetric(vertical: 16)
Styles.bodySectionPadding    // all(16)
Styles.sectionBottomPadding  // only(bottom: 16)
Styles.cardBorderRadius      // circular(12)
Styles.boardBorderRadius     // circular(5)
```

## Platform-Specific Theme Overrides (iOS)

| Component | iOS Override |
|---|---|
| `splashFactory` | `NoSplash.splashFactory` (no ink ripple) |
| `AppBar` | Translucent + backdrop blur, Cupertino nav title style |
| `CardTheme` | 0 elevation, `cardBorderRadius` (12dp) |
| `ListTile` | `minTileHeight: 48`, horizontal padding 16 |
| `DialogTheme` | 0 elevation, rounded 14dp |
| `BottomSheet` | 0 elevation, top corners 14dp |
| `FilledButton` | Border radius 10dp |
| `NavigationBar` | Translucent, matches app bar blur |

## Utility Functions

```dart
textShade(context, 0.7)     // DefaultTextStyle color with opacity
darken(color, 0.1)          // Darken a color by 10%
lighten(color, 0.1)         // Lighten a color by 10%
Styles.chartColor(context)  // ColorScheme.tertiary
```

## Brand Seed Color

Default seed: `Color(0xFF2196F3)` (blue).  
To rebrand: change `brandSeedColor` in `_makeDefaultTheme()` in `theme.dart`.

## Constants (`lib/src/constants.dart`)

```dart
kCupertinoBarOpacity   // translucency for bars
kCupertinoBarBlurSigma // blur sigma for backdrop filter
```
