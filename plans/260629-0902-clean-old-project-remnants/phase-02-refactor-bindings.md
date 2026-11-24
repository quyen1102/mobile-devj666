# Phase 2: Refactor hostnames & naming bindings

## Context Links
- [Scout Report](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/reports/scout-260629-0902-clean-old-project-remnants.md)

## Overview
- Priority: High
- Current Status: Pending
- Description: Refactor hostnames in `constants.dart` and rename `LichessBinding` and `LichessClient` to generic app bindings.

## Key Insights
- Generalizing prefix `Lichess` to `App` prevents coupling with the old brand.
- `LichessClient` can be renamed to `AppHttpClient`.

## Requirements
- Refactor references in `binding.dart`, `constants.dart`, `http.dart`.

## Related Code Files
- `lib/src/binding.dart`
- `lib/src/constants.dart`
- `lib/src/network/http.dart`

## Todo List
- [ ] Rename `LichessBinding` and `AppLichessBinding` in `binding.dart`
- [ ] Refactor prefix config names in `constants.dart`
- [ ] Rename `LichessClient` to `AppHttpClient` in `http.dart`

## Success Criteria
- Clean compilation and no remaining references to old bindings.
