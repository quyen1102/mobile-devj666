---
name: base-app-cleaner
description: Guides the removal of domain-specific business logic, assets, and configs to keep a clean base app shell for new projects.
version: 1.0.0
---

# Base App Cleaner — Project Base Extraction Guide

This skill provides a standardized checklist and guidelines for stripping domain-specific business logic, brand assets, and native packages to retain a clean template base shell for subsequent mobile app development.

## Cleaning Workflow

To clean the base app, execute the following steps in order:

1. **Clean Assets and Dependencies**: Remove unused domain-specific assets, fonts, native extension packages, and unnecessary pubspec dependencies. Refer to [Clean Assets & Dependencies](references/clean-assets-deps.md).
2. **Purge Business Logic Code**: Delete domain-specific view components and Riverpod controllers/models, and replace tab configurations in the main scaffold. Refer to [Clean Business Code](references/clean-business-code.md).
3. **Generalize Naming & Refactor Bindings**: Generalize any occurrences of legacy brand-specific names in constants, HTTP clients, bindings, and platform methods. Refer to [Generic Refactoring](references/generic-refactoring.md).
4. **Clean Localization**: Clean up translation source XML files and regenerate localized Dart strings. Refer to [Localization Cleanup](references/localization-cleanup.md).
5. **Verify and Format**: Compile the code generator and formatting tools to ensure correctness. Refer to the verification steps below.

## Verification Checklist

1. Run `flutter pub get` and `dart run build_runner build` to verify code generation completes without issues.
2. Run `flutter analyze` to verify that there are no static analyzer warnings or compile errors.
3. Run `dart format lib/src test` to format all modified source files.
4. Run `flutter test` to ensure that all basic framework and widget tests pass.

## References

- [Clean Assets & Dependencies](references/clean-assets-deps.md)
- [Clean Business Code](references/clean-business-code.md)
- [Generic Refactoring](references/generic-refactoring.md)
- [Localization Cleanup](references/localization-cleanup.md)
