---
name: app-logic-integrator
description: Integrate application logic into the base Flutter app while preserving visual styles, reusing widgets, and following Riverpod and Freezed coding conventions.
version: 1.0.0
---

# App Logic Integrator

This skill provides step-by-step instructions to read, parse, and implement application logic and business rules within the base tab-based Flutter application shell, ensuring consistency with the codebase styling and state management patterns.

## Core Directives

1. **Understand Logic Requirements First**: Parse business rules and functional flows completely. Do not write code before defining the state models and actions.
2. **Preserve App Styling**: Reuse base widgets from `lib/src/widgets/` (e.g. `PlatformScaffold`, `PlatformAppBar`, settings tiles, list sections) rather than raw Flutter ones.
3. **Keep Coding Standards**: Enforce strong typing, immutability (with Freezed, `fast_immutable_collections`), Riverpod 3.x, and keep files <200 lines.

## How to Use This Skill

Follow the references below to implement features:
- [Logic Analysis & Requirements](references/logic-analysis.md)
- [Adaptive Widget Mapping](references/widget-mapping.md)
- [Code Style & Riverpod Integration](references/code-style-integration.md)

## Core Documentation References

- [Coding Style Guide](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/docs/coding_style.md)
- [State Management (Riverpod & Freezed)](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/docs/state-management.md)
- [Theme & Styling Guide](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/docs/theme-styling.md)
- [Local Database & Secure Storage Guide](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/docs/database-storage.md)

