# Localization Cleanup Reference

This reference details the instructions for stripping legacy and domain-specific string keys from translation source files and regenerating the localization code.

## 1. Clean Translation Source File

Modify the master translation source files (e.g., XML translation sources, `.arb` source files, or JSON localizations) to retain only project-agnostic keys:

1. **Open the translation source files**:
   - Delete all domain-specific terms that are unique to the legacy application.
   - Retain only core app labels (e.g., `home`, `settings`, `notifications`, `account`, `error`, `loading`, `save`, `cancel`).

## 2. Regenerate Localization Code

Run translation generation scripts or standard localization compile tools to sync strings to the app's generated Dart files:

1. **Execute Translation Compiler**:
   - Run the compile script or standard command (e.g., `flutter gen-l10n`, or your project's custom localization build script).
   - This compiles raw translation templates and widgets-specific translation outputs.
2. **Verify Generated Output**:
   - Verify that new localization classes and keys are created under the localization output directory (e.g., `lib/l10n/` or your project's localized assets folder).
   - Do NOT edit generated localization files manually.

## 3. Clean Widget Translators

Fix references in files that access localized strings:

1. **Update Widget Translations**:
   - Search for occurrences of translation lookups (e.g., `context.l10n` or custom localization selectors) to ensure all keys still exist in the new translation structure.
   - Replace missing legacy translations with fallback constants or remove/refactor the widgets utilizing them.
