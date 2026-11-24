# Clean Assets & Dependencies Reference

This reference details the instructions for identifying and removing unused domain-specific dependencies, custom fonts, and brand assets from any codebase.

## 1. Clean `pubspec.yaml` Dependencies

Open `pubspec.yaml` and identify packages and declarations that are specific to the legacy domain or brand:

1. **Remove Domain-Specific Logic Packages**:
   - Scan the dependencies section for libraries implementing legacy app features or rules (e.g., custom gameplay engines, logic wrappers, or third-party domain APIs).
   - Delete these packages and run `flutter pub get`.
2. **Remove Unused Native Assets**:
   - Clean native folder declarations for custom iOS/Android extensions or assets if they are specific to the legacy brand.

## 2. Purge Domain Assets & Databases

Delete unnecessary directories, configuration files, and databases from the `assets/` directory to keep the project minimal:

1. **Delete Domain Databases**:
   - Locate and remove local databases (e.g., SQLite `.db` or `.sqlite` files, Realm files) containing domain-specific datasets.
2. **Delete Media, Images & Binary Assets**:
   - Remove folders containing custom themes, domain illustrations, piece sets, or external executable assets.
3. **Delete Static Mock Datasets**:
   - Remove legacy static JSON feeds, text files, or raw configurations.

## 3. Clean Native Extensions

Remove or disable native extensions that depend on brand-specific configurations:

1. **Clean iOS WidgetKit / Android Widget Extensions**:
   - Delete any brand-specific widget extension folders from the native projects.
   - Delete corresponding target references and bundle identifiers inside native build files (e.g., `Podfile`, Xcode `.pbxproj`, or Android `build.gradle`).
   - Remove shared app group configurations or entitlements from the native target settings if they are no longer needed.
