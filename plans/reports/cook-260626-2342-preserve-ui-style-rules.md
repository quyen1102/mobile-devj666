# Cook Report: UI Style Preservation & Component Reuse Rules Setup

Implementation progress and completion report for establishing visual preservation, component reuse, shell integrity rules, and rebranding bootstrap guidelines on the Shared Mobile Base project (`nf_base`).

## Tasks Summary

- **Status**: Completed (100% progress)
- **Time Completed**: 2026-06-26 23:51

## Completed Steps

1. **Renamed Skill to Generic Target**:
   - Renamed skill folder from `lichess-app-ui` to `shared-app-ui` to support generic templates rather than localized lichess branding.
2. **Created UI Preservation & Component Reuse Guide**:
   - Updated `references/ui-preservation-rules.md` inside the `shared-app-ui` skill.
   - Formulated strict requirements for reusing existing widgets in `lib/src/widgets/` and presets in [styles.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/styles/styles.dart) to speed up UI development and maintain layout consistency.
   - Enforced preservation of the TabBar navigation ([tab_scaffold.dart]) and Settings configurations (`lib/src/view/settings/` and `lib/src/model/settings/`).
3. **Updated Skill Entry**:
   - Modified `.agent/skills/shared-app-ui/SKILL.md` to reference `ui-preservation-rules.md` and updated descriptions.
4. **Updated Core Configs (Enforcement)**:
   - Modified `CLAUDE.md` to include component reuse and TabBar/Settings preservation under generic UI rules.
   - Updated `GEMINI.md` at root to enforce the same rules for Gemini-based agents.
5. **Created Rebrand Prompt Guide**:
   - Created [rebrand-bootstrap-prompt.md](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/docs/rebrand-bootstrap-prompt.md) to serve as a copy-pasteable bootstrap instruction for future AI agents to rebrand the base cleanly.
6. **Documentation**:
   - Updated `docs/project-changelog.md` and `docs/development-roadmap.md`.
7. **Walkthrough**:
   - Updated `walkthrough.md` in artifacts folder.
