# Brainstorming Report: App Logic Integrator Skill

**Date:** 260629
**Time:** 0852
**Task Slug:** create-app-logic-integrator-skill

## Overview

User wants a skill that inputs app logic, reads it in detail, integrates it with the current base app structure, and uses existing widget styles/templates (preserving visual guidelines for iOS and Android compatibility) to create new features or app flows, focusing strictly on logic implementation.

## Context & Constraints

1. **Base App Platform Adaptiveness**: Cupertino styles on iOS, Material 3 on Android. Use `PlatformScaffold`, `PlatformAppBar`.
2. **Branding and Themes**: Define colors via Theme/LichessColors, no hardcoding. Enable Dark Mode.
3. **Coding Standards**:
   - Immutability with `freezed` & `fast_immutable_collections`.
   - Strong typing.
   - Declarative/functional collection structures (`if`, `for`).
   - Prefer Widget classes over helper functions.
   - Files <200 lines (modularization).
4. **State Management**: Riverpod 3.x.
5. **Skill Creator Guidelines**:
   - `SKILL.md` < 150 lines.
   - References < 150 lines (progressive disclosure).
   - Concise YAML frontmatter description (<200 chars).
   - Imperative/infinitive instructions.

## Proposed Skill Architecture

Skill Folder: `.agent/skills/app-logic-integrator/`
- `SKILL.md`: Main entry point with frontmatter and instructions. Explains triggers and references.
- `references/logic-analysis.md`: Workflow to read logic, map requirements, model state.
- `references/widget-mapping.md`: Mapping of functional requirements to widgets in `lib/src/widgets/` & platform splits.
- `references/code-style-integration.md`: Practical steps to implement Riverpod 3, Freezed, immutability, file limits.

## Unresolved Questions / Design Decisions

- None. The guidelines are clearly defined in the existing docs/code.
