# iOS WidgetKit Integration Guide

This guide explains how the Flutter application communicates with the native iOS WidgetKit extension using the **App Group** shared suite.

---

## Architecture Overview

```
[Flutter App]
   |
   |-- (Uses home_widget package)
   |-- HomeWidget.saveWidgetData('username', value)
   v
[Shared UserDefaults (App Group Suite)]
   ^
   |-- (Swift Widget Extension)
   |-- Read using UserDefaults(suiteName: groupID)
   |
[iOS Widget Screen] (SwiftUI rendering)
```

Both targets (the main Flutter iOS runner and the `LichessWidgets` extension target) share a configured App Group ID, enabling synchronous data reading/writing.

---

## File Structure

- **Flutter side**:
  - `lib/src/app.dart`: Connects the app group ID using `HomeWidget.setAppGroupId(...)`.
  - `lib/src/model/account/account_service.dart`: Updates widget variables when account states refresh.
- **iOS side** (`ios/LichessWidgets/`):
  - `LichessWidgetsBundle.swift`: Bundle main entry registering `SampleDataWidget`.
  - `LichessAppGroup.swift`: Shared data layer declaring the App Group ID and key getters.
  - `SampleDataWidget.swift`: SwiftUI layout declaring the Widget Configuration, TimeLineProvider, and View.
  - `LichessWidgets.entitlements`: Xcode entitlements containing the allowed App Group strings.

---

## Flutter Implementation Details

1. **Initializing App Group**:
   Call this on app load (located in `app.dart`'s `initState`):
   ```dart
   if (Platform.isIOS) {
     HomeWidget.setAppGroupId('group.org.lichess.mobileV2.LichessWidgets');
   }
   ```

2. **Writing Data & Rebuilding Widget**:
   Update native preferences and request a widget timeline refresh (located in `account_service.dart`):
   ```dart
   HomeWidget.saveWidgetData('username', username);
   HomeWidget.saveWidgetData('lastUpdated', lastUpdatedString);
   HomeWidget.updateWidget(iOSName: 'SampleDataWidget');
   ```

---

## Swift Implementation Details

1. **Reading Data via App Group Suite** (`LichessAppGroup.swift`):
   ```swift
   enum LichessAppGroup {
       static let id = "group.org.lichess.mobileV2.LichessWidgets"

       static var username: String {
           UserDefaults(suiteName: id)?.string(forKey: "username") ?? "Guest"
       }
   }
   ```

2. **Widget Timeline Configuration** (`SampleDataWidget.swift`):
   ```swift
   struct SampleDataWidgetProvider: TimelineProvider {
       func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
           // Fetches fresh data from App Group and schedules next render
           let entry = SimpleEntry(
               date: Date(),
               username: LichessAppGroup.username,
               lastUpdated: LichessAppGroup.lastUpdated
           )
           let timeline = Timeline(entries: [entry], policy: .atEnd)
           completion(timeline)
       }
   }
   ```

---

## Setup Requirements for a New App

When renaming the base app or reusing this setup:
1. Register a new App Group ID on the [Apple Developer Portal](https://developer.apple.com/).
2. Enable the **App Groups** capability for both the **Runner** target and the **LichessWidgets** target in Xcode.
3. Update the App Group ID in:
   - `lib/src/app.dart` (`_kIosAppGroupId`)
   - `ios/LichessWidgets/LichessAppGroup.swift` (`id`)
   - `Runner.entitlements` and `LichessWidgets.entitlements` xml files.
