# Brainstorm: How to Reuse Lichess Mobile Base for New Apps

Evaluation of architectures and workflows to leverage the base codebase (`nf_base`) to build brand-new apps with customized business logic while keeping the UI style intact.

---

## 1. Problem Statement & Objectives

Developers want to spawn new applications from the `nf_base` codebase.
- **Goal**: Preserve visual styles, adaptive theme (iOS/Android), TabBar shell, and Settings flow.
- **Requirement**: Replace business logic (chess features) with new product logic (e.g., e-commerce, news, social) cleanly and efficiently.
- **Constraints**: Maintain maximum DRY and KISS principles; minimize developer friction.

---

## 2. Evaluated Approaches

### Approach A: Fork, Clean & Replace (Direct Replacement)
Duplicate the repository and surgically clean/replace Lichess-specific features while retaining the core infrastructure.

*   **How it works**:
    1. Duplicate project folder to `<your-new-app>`.
    2. Change app identity: `pubspec.yaml` (name, version), Android package name (`build.gradle`), iOS bundle ID (`Info.plist`).
    3. Modify `brandSeedColor` in `lib/src/theme.dart` to customize the primary theme color.
    4. Delete chess-specific logic directories (`lib/src/model/engine/`, `lib/src/model/game/`, etc.).
    5. Keep `lib/src/widgets/` (custom adaptive widgets), `lib/src/styles/` (spacing, colors), and settings structure.
    6. Rewrite custom business logic in `lib/src/model/` and screens in `lib/src/view/`.
    7. Update `lib/src/tab_scaffold.dart` to mount the new screens onto the 4 tabs.

*   **Pros**:
    - **Ultra-fast setup**: Start development immediately without changing the core architectural bindings.
    - Zero package management overhead (everything lives in a single monolithic repo).
- **Cons**:
    - Project history and code contains residual Lichess logic if not cleaned thoroughly.
    - Updates to the base app (bug fixes in widgets, etc.) cannot be easily synced back to the child apps.

---

### Approach B: Package-Based Architecture (Local Library Split)
Extract the UI design system, settings flow, and shell scaffolding into a standalone local package (`shared_app_core`) and import it into separate clean apps.

*   **How it works**:
    1. Strip this repository down so that it contains ONLY:
       - `lib/src/widgets/` (reusable widgets catalog).
       - `lib/src/styles/` and `lib/src/theme.dart` (theme presets).
       - `lib/src/tab_scaffold.dart` refactored to accept dynamic tab pages/icons as parameters.
       - Generic settings views and storage providers.
    2. Package this as a separate directory (or publish to a private Git repository).
    3. Create a brand-new Flutter project for the new app.
    4. In `pubspec.yaml`, add the dependency:
       ```yaml
       dependencies:
         shared_app_core:
           path: ../shared_app_core # or git repository
       ```
    5. In the new app's `main.dart`, invoke the exported `TabScaffold` and feed it with new views, providers, and parameters.

*   **Pros**:
    - **100% Clean codebase**: Child apps only contain their own logic and dependencies.
    - **Single source of truth**: Visual updates or bug fixes in `shared_app_core` instantly sync to all child apps.
- **Cons**:
    - **High initial complexity**: Refactoring `TabScaffold` and providers to be completely dynamic and dependency-free requires significant upfront engineering.
    - Multiple codebases to manage (library + multiple apps).

---

## 3. Final Recommendation

- **Use Approach A (Fork & Clean)** if you are building **only one or two** distinct applications. It is simple, requires zero refactoring of the base shell, and allows you to ship instantly.
- **Use Approach B (Core Package Split)** if you plan to launch a **suite of multiple applications** (e.g., 3+ white-label apps) inheriting the same UI shell. The long-term maintenance benefits outweigh the initial refactoring cost.

---

## 4. Implementation Steps (For Recommended Approach A)

To successfully reuse the codebase via **Approach A**:

1. **Clone & Identify**: Copy `mobile-devj666` and rename your directory.
2. **Rebrand Configuration**:
   - Update `name` in `pubspec.yaml`.
   - Run a search-and-replace for `package:nf_base/` imports to your new package name.
   - Modify `brandSeedColor` in `lib/src/theme.dart`.
3. **Clean Domain Logic**:
   - Delete directories under `lib/src/model/` that are chess-related (engine, puzzle, game, challenge).
   - Delete corresponding views under `lib/src/view/` (analysis, game, play, puzzle).
4. **Wire New Screens**:
   - Create your home/feature screens.
   - Edit [tab_scaffold.dart](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/lib/src/tab_scaffold.dart) to map the 4 bottom navigation items to your newly created screens.
5. **Verify**:
   - Run `flutter pub get`.
   - Run `dart run build_runner build` to regenerate serializations.
   - Execute `flutter run` to launch your new application with the exact same visual shell.
