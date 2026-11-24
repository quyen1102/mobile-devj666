# Phase 3: Generalize assets and auth

## Context Links
- [Scout Report](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/reports/scout-260629-0902-clean-old-project-remnants.md)

## Overview
- Priority: Medium
- Current Status: Pending
- Description: Clean unused chess images/svgs from `assets/` and parameterize/bypass OAuth scopes.

## Key Insights
- Unused webps like `anon-engine.webp` and `anon-face.webp` should be deleted to save space and remove old assets.
- OAuth endpoint configurations should read from environment config.

## Requirements
- Delete files from `assets/images/`.
- Clean links in `feedback.dart` and `auth_repository.dart`.

## Todo List
- [ ] Delete `anon-engine.webp`, `anon-face.webp`, `broadcast_image.png`, `radio-tower.svg`
- [ ] Clean SnackBar feedback link in `feedback.dart`
- [ ] Update `auth_repository.dart` to support generic endpoint configurations

## Success Criteria
- Asset folder cleaned, compilation holds.
