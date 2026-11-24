# Widget Catalog

All reusable widgets live in `lib/src/widgets/`. Import with `package:nf_base/src/widgets/...`.

## Platform-Adaptive Widgets (`platform.dart`)

### `PlatformScaffold`
Wrapper around `Scaffold` that automatically:
- Sets `extendBodyBehindAppBar: true` on iOS
- Reads `extendBody` from `MainTabScaffoldProperties`
- Adds transparent bottom padding container on iOS

```dart
PlatformScaffold(
  appBar: PlatformAppBar(title: Text('Screen')),
  body: ...,
)
```

### `PlatformAppBar`
`AppBar` with backdrop blur on iOS:

```dart
PlatformAppBar(
  title: Text('Title'),
  actions: [IconButton(...)],
  leading: BackButton(),
)
```

### `PlatformWidget`
Render different widgets per platform:

```dart
PlatformWidget(
  androidBuilder: (_) => Material3Widget(),
  iosBuilder: (_) => CupertinoWidget(),
)
```

### `PlatformShareIcon` / `PlatformAppBarLoadingIndicator`
Platform-correct share icon and loading spinner for AppBar.

## Button Widgets (`buttons.dart`)

### `SemanticIconButton`
Icon button with mandatory accessibility label:

```dart
SemanticIconButton(
  icon: Icon(Icons.favorite),
  onPressed: () {},
  semanticsLabel: 'Add to favorites',
)
```

### `OpacityButton`
Tappable wrapper with 0.5 opacity press feedback (iOS-style):

```dart
OpacityButton(
  onPressed: () {},
  child: MyCustomWidget(),
)
```

### `RepeatButton`
Long-press repeating button with acceleration:

```dart
RepeatButton(
  onLongPress: () => decrement(),
  child: IconButton(icon: Icon(Icons.remove), onPressed: decrement),
)
```

### `LoadingButtonBuilder<T>`
Tracks async future state for loading indicators:

```dart
LoadingButtonBuilder<void>(
  fetchData: () => repository.save(),
  builder: (context, isLoading, fetch) => FilledButton(
    onPressed: isLoading ? null : fetch,
    child: isLoading ? CircularProgressIndicator() : Text('Save'),
  ),
)
```

## List Widgets (`list.dart`)

Use widgets from `list.dart` for consistent list item styling.

## Settings Widgets (`settings.dart`)

For settings screens — use the provided settings tile/group widgets for consistent iOS/Material styling.

## Shimmer Loading (`shimmer.dart`)

For skeleton loading states. Use `ShimmerLoading` wrapper.

## Feedback Widgets (`feedback.dart`)

For snackbars, toasts, error states. Platform-adaptive feedback.

## Background (`background.dart`)

`FullScreenBackground` — wraps the root scaffold to support background images/colors from settings.

## Adaptive Sheets (`adaptive_action_sheet.dart`, `adaptive_bottom_sheet.dart`)

```dart
// Action sheet (iOS ActionSheet / Android bottom sheet)
showAdaptiveActionSheet(context, actions: [...]);

// Bottom sheet
showAdaptiveBottomSheet(context, builder: (_) => Widget());
```

## Adaptive Choice Picker (`adaptive_choice_picker.dart`)

For selecting from options (iOS wheel picker / Material dialog).

## `StatCard` (`stat_card.dart`)

Display stat label + value in a card format.

## `TextBadge` (`text_badge.dart`)

Small badge/chip widget for labels.

## Network Image (`network_image.dart`)

Cached network image with fallback.

## Progression Widget (`progression_widget.dart`)

Rating/progress delta display (positive = green, negative = red).

## `HapticRefreshIndicator` (`haptic_refresh_indicator.dart`)

Pull-to-refresh with haptic feedback.

## Style Helpers

```dart
textShade(context, opacity)  // Text color with opacity
darken(color, amount)        // Darken color
lighten(color, amount)       // Lighten color
```
