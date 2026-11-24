---
title: Implement Adaptive Icons
description: Replace legacy LichessIcons and SocialIcons with standard platform-adaptive AppIcons class mapping Material and Cupertino icons.
status: completed
priority: high
effort: medium
branch: feat/adaptive-icons
tags: [icons, cleanup, styles]
created: 2026-06-29
---

# Plan: Implement Adaptive Icons

Overview of the plan to clean up legacy custom icon configurations and integrate a unified platform-adaptive `AppIcons` configuration.

## Phases

### [Phase 1: Implement AppIcons & Refactor Widgets](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/260629-1120-implement-adaptive-icons/phase-01-implement-app-icons.md)
- **Status**: completed
- **Description**: Create the [app_icons.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/app_icons.dart) class with the user-provided mapping. Update [progression_widget.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/progression_widget.dart) and [list.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/widgets/list.dart) to use it.
- **Dependencies**: None.

### [Phase 2: Legacy Icons Cleanup](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/260629-1120-implement-adaptive-icons/phase-02-cleanup-legacy-icons.md)
- **Status**: completed
- **Description**: Delete legacy files ([lichess_icons.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/lichess_icons.dart), [social_icons.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/social_icons.dart), [fluttericon.json](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/fluttericon.json)), remove font files, and clean [pubspec.yaml](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/pubspec.yaml).
- **Dependencies**: Phase 1.
