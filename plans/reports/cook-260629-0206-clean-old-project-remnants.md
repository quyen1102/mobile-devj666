# Clean Old Project Remnants Report

Completed the refactoring of Lichess-specific references to establish a clean base app.

## Changes Made
- **Refactored bindings:** Renamed `LichessBinding` -> `BaseAppBinding` and `AppLichessBinding` -> `AppBinding` in `lib/src/binding.dart` and references across initialization, storage, log, and notifications.
- **Refactored hostnames & configs:** Renamed `kLichessHost`, `kLichessWSHost`, `kLichessWSSecret`, `kLichessCDNHost`, `kLichessCustomUriSchemeName`, etc. to generic `kApp*` equivalents in `lib/src/constants.dart` and usages.
- **Renamed HTTP Client:** Renamed `LichessClient` -> `AppHttpClient`, `lichessClientProvider` -> `appHttpClientProvider`, and `lichessUri` -> `appUri` in `lib/src/network/http.dart` and other repository classes (`message_repository.dart`, `account_repository.dart`, `aggregator.dart`, `auth_repository.dart`).
- **Cleaned Assets:** Deleted unused chess assets (`anon-engine.webp`, `anon-face.webp`, `broadcast_image.png`, `radio-tower.svg` from `assets/images/`).
- **Feedback & Database:** Updated feedback SnackBar check url to `example.com` and database name to `app_mobile.db`.

## Verification Results
- Ran code generation (`dart run build_runner build`) successfully.
- Ran static analysis (`flutter analyze`) which completed successfully without any compilation errors.
