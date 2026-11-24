# Navigation & Tab Shell

## Tab Structure (`lib/src/tab_scaffold.dart`)

The app uses a 4-tab bottom navigation shell: **Home, Notifications, Settings, Account**.

### Tab Enum

```dart
enum BottomTab { home, notifications, settings, account }
```

Each tab has:
- `label(AppLocalizations)` — localized string
- `icon` — `Symbols.*_rounded` icon (Material Symbols)

### Key Providers

```dart
currentBottomTabProvider     // StateProvider<BottomTab> — active tab
currentNavigatorKeyProvider  // Provider<GlobalKey<NavigatorState>>
currentRootScrollControllerProvider // Provider<ScrollController>
```

### Navigator Keys (one per tab)

```dart
homeNavigatorKey         // GlobalKey<NavigatorState>
notificationsNavigatorKey
settingsNavigatorKey
accountNavigatorKey
```

### Scroll Controllers (one per tab)

```dart
homeScrollController
notificationsScrollController
settingsScrollController
accountScrollController
```

### Tab Interaction (double-tap behavior)

When user taps the **active** tab:
1. Pops navigator to root if `canPop()`
2. Scrolls to top if `scrollController.offset > 0`
3. Fires `*TabInteraction.notifyItemTapped()` for custom refresh

```dart
homeTabInteraction          // _BottomTabInteraction (ChangeNotifier)
notificationsTabInteraction
settingsTabInteraction
accountTabInteraction
```

## Adding a New Tab

1. Add entry to `BottomTab` enum with `label()` and `icon`
2. Add `GlobalKey<NavigatorState>` and `ScrollController`
3. Add `_BottomTabInteraction` instance
4. Add case in `currentNavigatorKeyProvider` and `currentRootScrollControllerProvider`
5. Add `case` in `_tabBuilder` returning `_MaterialTabView` with the screen widget
6. Update `MainTabScaffold` bottom bar items

## Platform-Adaptive Bottom Bar

```dart
// iOS — custom _CupertinoTabBar (translucent + blur)
_CupertinoTabBar(
  height: 50,
  backgroundColor: NavigationBarTheme.of(context).backgroundColor,
  border: Border(top: BorderSide(color: Colors.transparent)),
  activeColor: ColorScheme.of(context).onSurface,
  ...
)

// Android — Material 3 NavigationBar
NavigationBar(selectedIndex: ..., destinations: [...])
```

## Screen Navigation inside a Tab

Use `Navigator.of(context).push(...)` within the tab's navigator scope.  
Each tab has its own `_MaterialTabView` with isolated navigator.

## `MainTabScaffoldProperties`

`InheritedWidget` that propagates `extendBody` to child scaffolds.

```dart
// In any screen inside a tab:
final extendBody = MainTabScaffoldProperties.hasExtendedBody(context);
```

## Deep Links

Handled by `lib/src/app_links_service.dart`. Register new routes in `AppLinksService`.
