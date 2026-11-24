# Cook Report: Make Base App Cleaner Skill Fully Generic

- Generalized all file references, class names, and directories in `base-app-cleaner` skill and references.
- Replaced hardcoded paths (e.g. `lib/src/tab_scaffold.dart`, `translation/source/mobile.xml`, `ios/LichessWidgets/`) with abstract descriptions and patterns (e.g., `<Brand>CustomColors`, `MyBrandBinding`, and directories `lib/src/view/` or `lib/views/`).
- Verified zero occurrences of the words "lichess" or "chess" in the skill folder.
- All files satisfy the line count limit (<150 lines).
