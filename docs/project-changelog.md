# Project Changelog

All notable changes to the Shared Mobile Base (`nf_base`) project will be documented in this file.

---

## [1.2.2] - 2026-06-29

### Added
- Created seven new platform-adaptive widgets under `lib/src/widgets/`:
  - [platform_text_field.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/platform_text_field.dart): Adaptive input wrapper mapping Cupertino and Material text field variants.
  - [platform_switch_list_tile.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/platform_switch_list_tile.dart): Adaptive settings tile wrapper mapping Cupertino list tile and Material switch list tile variants.
  - [platform_date_picker.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/platform_date_picker.dart): Static wrapper utility triggering a Cupertino bottom sheet picker or a Material calendar picker dialog.
  - [empty_state_widget.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/empty_state_widget.dart): Generic display box with illustration, title, description, and action button alignment.
  - [platform_loading_overlay.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/platform_loading_overlay.dart): Stack-based loader with backdrop filter blur on iOS.
  - [platform_card.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/platform_card.dart): Subtle border flat container on iOS and elevated card on Android.
  - [platform_avatar.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/platform_avatar.dart): Circular avatar container with loading, error initials fallback, and online indicator badge.

## [1.2.1] - 2026-06-29

### Added
- Integrated the new platform-adaptive [AppIcons](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/app_icons.dart) class containing Cupertino and Material icon mappings.

### Changed
- Refactored [progression_widget.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/progression_widget.dart) to use `AppIcons.trendingUp` and `AppIcons.trendingDown` for trends.
- Refactored [list.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/list.dart) to use `AppIcons.chevronRight` for list section chevrons.

### Removed
- Cleaned up unused legacy custom icon font configurations and files:
  - Deleted legacy font mapping files [lichess_icons.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/lichess_icons.dart) and [social_icons.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/social_icons.dart).
  - Deleted config [fluttericon.json](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/fluttericon.json).
  - Deleted font binary `assets/fonts/SocialIcons.ttf` and removed the font registration from [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml).

## [1.2.0] - 2026-06-29

### Added
- Created `app-logic-integrator` skill (under `.agent/skills/app-logic-integrator`) to read natural language logic and map it into the existing base app styling, reusing platform-adaptive widgets and conforming to Riverpod, Freezed, and file size conventions.
- Added `logic-analysis.md`, `widget-mapping.md`, and `code-style-integration.md` references to support progressive disclosure for the new skill.

## [1.1.0] - 2026-06-26

### Added
- Created `shared-app-ui` skill (renamed from `lichess-app-ui`) to guide development of new screens while keeping consistent layouts.
- Created `ui-preservation-rules.md` inside `shared-app-ui` references, detailing component/style reuse and preservation of TabBar/Settings flows.
- Created `GEMINI.md` file at project root to set instructions for Gemini-based agents, enforcing generic app UI preservation.
- Integrated strict `UI Style Preservation & Component Reuse Rules` into `CLAUDE.md`.
- Created `rebrand-bootstrap-prompt.md` in `docs/` as a ready-to-use template prompt for AI agent initialization.

### Changed
- Updated `SKILL.md` to reference the new UI style preservation and component reuse guide.


