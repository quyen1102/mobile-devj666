# Phase 1: Scout lichess-specific references

## Context Links
- [Brainstorming Report](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/reports/brainstormer-260629-0902-clean-old-project-remnants.md)

## Overview
- Priority: High
- Current Status: In Progress
- Description: Find and categorize all remaining lichess-specific assets, variables, strings, bindings, and dependencies.

## Key Insights
- We have 150+ occurrences of "lichess" across `lib/src/`.
- Naming bindings (`LichessBinding`), clients (`LichessClient`), hostnames (`kLichessHost`), assets, and auth scopes are direct legacy remnants.

## Requirements
- Compile a list of specific files containing references that need generalization.

## Related Code Files
- `lib/src/binding.dart`
- `lib/src/constants.dart`
- `lib/src/model/auth/auth_repository.dart`

## Implementation Steps
1. Perform detailed searches across all source code.
2. Compile and save the scout report.

## Todo List
- [x] Search references of lichess-specific terminology
- [x] Complete scout report

## Success Criteria
- Detailed identification of all legacy elements to clean.

## Risk Assessment
- None.

## Security Considerations
- None.

## Next Steps
- Move to Phase 2: Refactor hostnames & naming bindings.
