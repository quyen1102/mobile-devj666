# Scout Report: App Logic Integrator Skill

**Date:** 260629
**Time:** 0852
**Task Slug:** create-app-logic-integrator-skill

## Discovery of Base Elements

### Layout & Adaptive Design
- `PlatformScaffold` & `PlatformAppBar` (in `lib/src/widgets/platform.dart`) automatically detect iOS / Android platforms and adapt look-and-feel.
- Navigation utilizes `MainTabScaffoldProperties.hasExtendedBody`.

### Settings & List Widgets
- `ListSection` & `ListSectionHeader` (in `lib/src/widgets/list.dart`) construct grouped card-based lists.
- `SettingsListTile`, `SwitchSettingTile`, `SliderSettingsTile`, and `ChoicePicker` (in `lib/src/widgets/settings.dart`) handle individual preference selections.

### State & Coding Style
- Riverpod for states (typically `Notifier` or `AsyncNotifier`).
- Freezed generated files for immutable data transfer objects.
- Collections: `fast_immutable_collections` (`IList`, `IMap`) to enforce immutability.
- Imperative layouts / helper functions that return widgets are forbidden; prefer standard `StatelessWidget` classes.
