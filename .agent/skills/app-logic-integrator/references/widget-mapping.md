# Adaptive Widget Mapping

Map application views and inputs to reusable platform-adaptive components to preserve visual style.

## Layout Scaffolding
- Do not use raw Flutter `Scaffold` or `AppBar` inside tab navigation.
- Use `PlatformScaffold` for screen body structure.
- Use `PlatformAppBar` for screen app bars. These widgets automatically handle Cupertino transparency on iOS and Material 3 layouts on Android.

## Settings & Forms
Use existing widgets from `lib/src/widgets/settings.dart` and `lib/src/widgets/list.dart`:
- **Grouped settings**: Wrap items in `ListSection` with optional `ListSectionHeader`.
- **Toggles / Switched Options**: Use `SwitchSettingTile` for boolean options.
- **Tappable options**: Use `SettingsListTile` to transition or show select dialogs.
- **Sliders / Ranges**: Use `SliderSettingsTile` for numeric controls.
- **Choice Lists**: Use `ChoicePicker` to pick one option from a list.

## Color System Compliance
- Query colors dynamically via context: `Theme.of(context).colorScheme.*` or extension `context.lichessColors.*`.
- Do not use hardcoded hex color values or `Colors.*` references directly in UI views.
- Ensure all custom layouts read brightness for dark mode support.

## Related Documentation

- [Theme & Styling Guide](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/docs/theme-styling.md)

