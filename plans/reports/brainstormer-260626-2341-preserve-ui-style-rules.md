# Brainstorm: UI Preservation Rules for Lichess Mobile Base

Analysis of options and rules to ensure the UI style and identity are preserved when developers or AI agents inherit this codebase to build other apps.

## Context & Objectives

This project (`nf_base`) serves as a base repository. When developers fork it to build new apps:
- The visual identity (layout, navigation shell, component styles) must remain intact.
- Developers should only customize business logic, assets (logos, icons), app names, and the primary brand color.
- We need to establish strict, automated rules for AI agents and clear guidelines for human developers to prevent regression or modification of core UI files.

## Technical Preservation Areas

| Component | Preservation Level | Allowed Customization | Files involved |
|---|---|---|---|
| **Theme System** | High | `brandSeedColor` only | `lib/src/theme.dart` |
| **Color Palette** | Strict | None (fixed color system) | `lib/src/styles/` |
| **Widget Library** | Strict | Custom themes for new views | `lib/src/widgets/` |
| **Navigation Shell** | Strict | Tab titles, icons, routing targets | `lib/src/tab_scaffold.dart` |
| **App Branding** | High (Customizable) | App Name, Assets, Package Name | `pubspec.yaml`, `assets/`, Android/iOS config |

## Proposed Strategy

### Option 1: Enhance `CLAUDE.md` and Create `GEMINI.md` at Project Root
- **Why**: AI agents (Claude, Gemini) read these files upon initialization. Defining UI preservation rules here acts as a strict guardrail.
- **Rules to enforce**:
  - Do not edit files under `lib/src/styles/` or `lib/src/widgets/` unless fixing platform bugs.
  - Customization of theme must be done strictly via `brandSeedColor` in `lib/src/theme.dart`.
  - UI screens must inherit and use custom widget catalog (e.g., `PlatformScaffold`, `PlatformAppBar`).

### Option 2: Define UI Preservation Rules inside `lichess-app-ui` Skill
- **Why**: The skill is the manual/interactive guide for UI implementation. Adding `ui-preservation-rules.md` ensures that any time the agent runs a UI action, it follows the constraints.
- **Content**: Detailed "Dos and Don'ts" mapping.

### Option 3: Combination (Recommended)
1. Cập nhật `CLAUDE.md` với section `UI Preservation & Customization Rules`.
2. Tạo `GEMINI.md` ở project root (đồng bộ với `CLAUDE.md`).
3. Tạo `references/ui-preservation-rules.md` trong skill `lichess-app-ui` và liên kết trong `SKILL.md`.

## Detailed Preservation Rules Draft

### 1. Theme and Color Preservation
- **Strict Limitation**: `LichessColors` and `LichessCustomColors` MUST NOT be modified. If the app needs a custom brand color, only modify `brandSeedColor` in `lib/src/theme.dart`.
- **Contrast and Mode**: Dark/Light mode support is mandatory. All custom UI components must use `Theme.of(context).colorScheme` values. Do not use hardcoded black/white colors for UI backgrounds or texts.

### 2. Widget Preservation
- The core widget library (`lib/src/widgets/`) contains adaptive platform-specific widgets. Do not replace them with raw Material `Scaffold` or Cupertino `CupertinoPageScaffold`.
- Any new features must use `PlatformScaffold`, `PlatformAppBar`, and `PlatformButton` from the base catalog.

### 3. Shell Integrity
- `lib/src/tab_scaffold.dart` controls the global navigation shell. The structure of the 4 tabs, deep linking, and layout must not be changed. Only the active route mappings and menu items within the tabs can be swapped for new business logic.

## Action Plan
- **Step 1**: Write `ui-preservation-rules.md` reference inside the `lichess-app-ui` skill.
- **Step 2**: Update `.agent/skills/lichess-app-ui/SKILL.md` to reference the rules.
- **Step 3**: Add `UI Preservation Rules` section into `CLAUDE.md`.
- **Step 4**: Create `GEMINI.md` at the project root for Gemini-specific context enforcement.
