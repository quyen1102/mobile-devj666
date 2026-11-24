# Phase 2: Design reference documents

## Context Links
- [Skill Creator Guide](file:///Users/devj666/.gemini/config/skills/skill-creator/SKILL.md)
- [Brainstorming Report](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/reports/brainstormer-260629-1410-create-base-app-cleaner-skill.md)

## Overview
- Priority: High
- Current Status: Completed
- Description: Design and write the supporting reference documents in `.agent/skills/base-app-cleaner/references/` to implement specific clean-up actions.

## Key Insights
- Each reference file must be strictly under 150 lines.
- Organize references logically into:
  - `clean-assets-deps.md`: For assets, fonts, and pubspec dependencies.
  - `clean-business-code.md`: For models and views.
  - `generic-refactoring.md`: For binding layer, HTTP client, and constants renames.
  - `localization-cleanup.md`: For translations and app links.

## Requirements
- Create four reference files under `.agent/skills/base-app-cleaner/references/`:
  - `clean-assets-deps.md`
  - `clean-business-code.md`
  - `generic-refactoring.md`
  - `localization-cleanup.md`
- Ensure each file details actionable rules using imperative form.

## Implementation Steps
1. Write `clean-assets-deps.md` detailing deleting unused assets and updating pubspec.yaml.
2. Write `clean-business-code.md` detailing deleting chess models/views.
3. Write `generic-refactoring.md` detailing the naming replacements for Binding and Client.
4. Write `localization-cleanup.md` detailing XML source translation modifications.
5. Check line count for all reference files (< 150 lines).

## Todo List
- [ ] Implement `clean-assets-deps.md`
- [ ] Implement `clean-business-code.md`
- [ ] Implement `generic-refactoring.md`
- [ ] Implement `localization-cleanup.md`
- [ ] Check line count of all reference files

## Success Criteria
- All reference files created, meeting length and style guidelines.

## Risk Assessment
- None.

## Security Considerations
- None.

## Next Steps
- Phase 3: Validate and package skill.
