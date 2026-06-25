# Internationalisation

We are using the official Flutter way of internationalising our app, as described in the [documentation](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization#setting-up).

In this generic starter template, translations are defined locally.

ARB files are located in the `lib/l10n/` directory (e.g., `app_en.arb`, `app_vi.arb`). 

To generate translation Dart classes from ARB files, run:
```bash
flutter gen-l10n
```

If you are using the native iOS widget extension, a helper script, `scripts/gen-widget-strings.mjs`, generates `ios/LichessWidgets/Localizable.xcstrings` from the translations to enable internationalisation of the SwiftUI widgets.

All translation compilation steps are combined in a single shell script:
```bash
./scripts/gen-translations.sh
```

---

## How to Add New Translations

To add a new translation string:
1. Open `lib/l10n/app_en.arb`.
2. Add your key and value (following ARB file format guidelines).
3. If necessary, add translations for other locales in their corresponding `.arb` files.
4. Run `flutter gen-l10n` to compile.

### Local XML translation system (Optional)
The codebase includes legacy scripts (`scripts/gen-arb.mjs`) that process translations from XML files in the `translation/` directory. If you prefer to manage translations in XML format, you can edit `translation/source/mobile.xml` and then run:
```bash
./scripts/gen-translations.sh
```

---

## Developer Tips

> **Note**
> When working on a new feature, start by hardcoding English texts first. Once the feature is completed and verified, add them to `app_en.arb` to keep translation maintenance organized.

For keys in `mobile.xml` (if using the XML-based pipeline), a `mobile` prefix is added in Dart (e.g. `foo` turns into `mobileFoo` in code).
