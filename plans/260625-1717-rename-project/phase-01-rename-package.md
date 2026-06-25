# Phase 1: Package and Import Renaming

## Context Links
- **Master Plan**: [plan.md](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/260625-1717-rename-project/plan.md)
- **Pubspec**: [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml)

## Overview
- **Priority**: High
- **Status**: Completed
- **Description**: Migrate all Dart codebase imports from `package:lichess_mobile/` to `package:nf_base/` and rename native app bundles to `com.example.base`.

## Key Insights
- Modifying imports across 70+ files was safely done using global replacements.
- The `change_app_package_name` tool renamed native package paths for Android and iOS successfully.
- Clean and build commands regenerated all freezing classes cleanly.

## Requirements
- All files inside `lib/` and `test/` compile with the new package name `nf_base`.
- Android App ID is updated to `com.example.base`.
- iOS Bundle ID is updated to `com.example.base`.

## Architecture
Configuration migration phase affecting build configurations and import pathways across the entire Dart and Native environments.

## Related Code Files
- [MODIFY] [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml) (Changed name to `nf_base`)
- [MODIFY] Dart source files under `lib/` and `test/` (Updated package imports to `package:nf_base/...`)
- [MODIFY] Android gradle and manifest files (Updated applicationId to `com.example.base`)
- [MODIFY] iOS xcconfig and plist files (Updated bundle ID to `com.example.base`)

## Implementation Steps
1. **Dart Name Update**: Changed `name: lichess_mobile` to `name: nf_base` inside `pubspec.yaml`. (Completed)
2. **Global Import Replacement**: Globally replaced `package:lichess_mobile/` with `package:nf_base/` inside the `lib` and `test` directories. (Completed)
3. **Android/iOS Package ID Rename**:
   - Added `change_app_package_name` package to pubspec.
   - Ran `dart run change_app_package_name:main com.example.base` to rename package folders and IDs. (Completed)
4. **Clean & Build**:
   - Ran `flutter clean`
   - Ran `flutter pub get`
   - Ran `dart run build_runner build` to regenerate serializers with the new imports. (Completed)
5. **Xcode entitlements & app group ID verify**: Swapped all App Groups to `group.com.example.base.widgets` and `group.com.example.base.share` to match the new bundle ID structures. (Completed)

## Todo List
- `[x]` Update `pubspec.yaml` name to `nf_base`
- `[x]` Run global sed/perl replace to update Dart imports
- `[x]` Run package renamer for native Android/iOS ID `com.example.base`
- `[x]` Run clean and rebuild code generation
- `[x]` Verify static analysis `flutter analyze` has no errors

## Success Criteria
- Dart code compiles cleanly with `flutter analyze` returning 0 errors. (Completed)
- Native configurations successfully migrated. (Completed)
