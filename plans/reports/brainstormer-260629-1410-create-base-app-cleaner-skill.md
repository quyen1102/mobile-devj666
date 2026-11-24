# Brainstorming: Base App Cleaner Skill Design

## Context
The user wants to create a custom agent skill (`base-app-cleaner`) that lists and details the tasks required to strip away Lichess-specific business logic and dependencies from the codebase. This ensures that any new mobile project can be configured cleanly using this repository as a base.

## Skill Objectives
The custom skill must provide:
1. Clear guidance on stripping chess and Lichess-specific files, assets, and dependencies.
2. Step-by-step instructions for refactoring and generalizing Lichess-specific naming in bindings, network classes, and constants.
3. Steps to verify the clean base app compilation and configuration.
4. Clean localization cleanup process.

## Skill Folder Structure (.agent/skills/base-app-cleaner)
- `SKILL.md`: Main entry point (under 150 lines). Concise description, quick checklist, and references.
- `references/clean-assets-deps.md`: Steps to clean `pubspec.yaml`, delete unused assets/fonts, and manage mobile extensions.
- `references/clean-business-code.md`: Steps to purge chess-specific models and views from `lib/src/model/` and `lib/src/view/`.
- `references/generic-refactoring.md`: Guide to generalize bindings (`LichessBinding` -> `AppBinding`), HTTP clients (`LichessClient` -> `AppHttpClient`), and constants.
- `references/localization-cleanup.md`: Clean translations workflow via source XML and generating basic ARB files.

## Alignment with Skill Creator Guidelines
- Ensure all markdown files are strictly under 150 lines.
- Write descriptions in YAML frontmatter under 200 characters.
- Use imperative, verb-first instructions (e.g. "Do X", "Remove Y").
- Defer detailed instructions to references to respect progressive disclosure.
