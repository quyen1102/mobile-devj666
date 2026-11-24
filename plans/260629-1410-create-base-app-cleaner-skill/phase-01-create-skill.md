# Phase 1: Create skill shell and main instructions

## Context Links
- [Skill Creator Guide](file:///Users/devj666/.gemini/config/skills/skill-creator/SKILL.md)
- [Brainstorming Report](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/plans/reports/brainstormer-260629-1410-create-base-app-cleaner-skill.md)

## Overview
- Priority: High
- Current Status: Completed
- Description: Set up the folder structure for `.agent/skills/base-app-cleaner/` and implement the main `SKILL.md` file.

## Key Insights
- The `SKILL.md` must be under 150 lines.
- Frontmatter description must be under 200 characters and use 3rd-person style.
- Use imperative, verb-first instructions for the step-by-step checklist.

## Requirements
- Create directory `.agent/skills/base-app-cleaner/`.
- Create `.agent/skills/base-app-cleaner/SKILL.md` with:
  - Name: `base-app-cleaner`
  - Description: Guides the removal of Lichess-specific business logic, assets, and configs to keep a clean base app shell for new projects.
  - Step-by-step generic workflow checklist referencing reference files.

## Related Code Files
- [base-app-cleaner SKILL.md](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/.agent/skills/base-app-cleaner/SKILL.md)

## Implementation Steps
1. Create the skill directory `.agent/skills/base-app-cleaner/` and its `references` subdirectory.
2. Implement the `SKILL.md` file with metadata and high-level workflow.
3. Validate the `SKILL.md` file line count (ensure it is <150 lines).

## Todo List
- [ ] Create skill folders
- [ ] Implement `SKILL.md`
- [ ] Validate `SKILL.md` line count

## Success Criteria
- Skill folder structure initialized.
- `SKILL.md` passes metadata checks and is under 150 lines.

## Risk Assessment
- None.

## Security Considerations
- None.

## Next Steps
- Phase 2: Design reference documents.
