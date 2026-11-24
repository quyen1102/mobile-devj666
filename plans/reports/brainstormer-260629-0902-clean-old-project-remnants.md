# Brainstorming Report: Clean Old Project Remnants

**Date:** 260629
**Time:** 0902
**Task Slug:** clean-old-project-remnants

## Overview
The goal is to clean up lichess-specific remnants and redundant code to turn the repository into a pure, generic, reusable Flutter tab-based base app (`nf_base`).

## Key Discoveries & Targets
1. **Lichess Hostnames and URLs**:
   - `kLichessHost`, `kLichessWSHost`, etc. in `lib/src/constants.dart`.
   - Direct links like `https://lichess.org/lag` in SNACKBAR/UI components.
2. **Naming Conventions**:
   - `LichessBinding` / `AppLichessBinding` in `lib/src/binding.dart` can be generalized or renamed to `BaseAppBinding` / `AppBinding`.
   - `LichessClient` can be generalized to `BaseHttpClient`.
   - `LichessColors` / `LichessIcons` contain generic colors & icons, but the name is Lichess-specific.
3. **Authentication Endpoint**:
   - OAuth in `lib/src/model/auth/auth_repository.dart` points directly to lichess.org. A base app should ideally have configurable endpoints or a clean dummy auth flow.
4. **Locales/L10n**:
   - The `.arb` files contain massive lichess-specific strings. While i18n is great, keeping all 100+ translation files of lichess chess terms is overkill. Keep standard ones (`en`, `vi`) and clean them.

## Proposed Strategy
- Define a generic configuration in `lib/src/constants.dart` (replacing hardcoded lichess links with configurable env parameters).
- Rename/generalize `LichessBinding` / `LichessClient` to generic terms.
- Generalize SnackBar feedback links.
- Create an implementation plan detailing the files to modify.
