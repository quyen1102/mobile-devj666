# Phase 2: Design and create skill instructions

## Context Links
- [Skill Creator Guide](file:///Users/devj666/.gemini/config/skills/skill-creator/SKILL.md)
- [Base UI Rules](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/.agent/skills/shared-app-ui/SKILL.md)

## Overview
- Priority: High
- Current Status: In Progress
- Description: Design and create the `app-logic-integrator` skill folder, including the `SKILL.md` and related references to guide code generation matching base app conventions.

## Key Insights
- Skill files should use progressive disclosure to keep `SKILL.md` under 150 lines.
- The description in YAML frontmatter must be concise (under 200 characters).
- Imperative/infinitive verb-first instructions are required.

## Requirements
- Create folder `.agent/skills/app-logic-integrator/`.
- Create `.agent/skills/app-logic-integrator/SKILL.md`.
- Create `.agent/skills/app-logic-integrator/references/`.
- Create references:
  - `references/logic-analysis.md`: Detailed natural language logic extraction and state modeling.
  - `references/widget-mapping.md`: Mapping functionalities to existing base widgets.
  - `references/code-style-integration.md`: Code style integration rules (immutability, strong typing, folder structures).

## Architecture
- A modular skill structure parsing application requirements and matching them with Riverpod, Freezed, and Cupertino/Material 3 hybrid views.

## Related Code Files
- [shared-app-ui SKILL.md](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/.agent/skills/shared-app-ui/SKILL.md)

## Implementation Steps
1. Create skill directory and subdirectories.
2. Implement `SKILL.md`.
3. Implement references under `references/`.
4. Validate that all files satisfy line count limit (<150 lines).

## Todo List
- [ ] Create skill folders
- [ ] Write `SKILL.md`
- [ ] Write logic-analysis.md reference
- [ ] Write widget-mapping.md reference
- [ ] Write code-style-integration.md reference

## Success Criteria
- Skill correctly formatted and meets validation criteria (<150 lines, frontmatter under 200 chars).

## Risk Assessment
- None.

## Security Considerations
- None.

## Next Steps
- Move to Phase 3: Verify and validate skill.
