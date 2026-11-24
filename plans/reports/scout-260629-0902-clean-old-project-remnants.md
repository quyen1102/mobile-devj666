# Scout Report: Clean Old Project Remnants

**Date:** 260629
**Time:** 0902
**Task Slug:** clean-old-project-remnants

## Legacy Elements Directory

### 1. Bindings (`lib/src/binding.dart`)
- Contains `LichessBinding` and `AppLichessBinding`. These bind SharedPreferences, clock, package info, and platform specifics.
- *Refactor target*: Generalize to `BaseAppBinding` and `AppBinding`.

### 2. Network Client (`lib/src/network/http.dart`)
- `LichessClient` and `lichessClientProvider` are used to perform HTTP requests.
- `lichessUri` helper constructs URLs mapping to the environment host.
- *Refactor target*: Generalize to `AppHttpClient`, `appHttpClientProvider`, and `appUri`.

### 3. Constants (`lib/src/constants.dart`)
- Lichess-specific host configuration variables:
  - `kLichessHost`, `kLichessWSHost`, `kLichessWSSecret`, `kLichessCDNHost`, `kLichessOpeningExplorerHost`, `kLichessTablebaseHost`, `kLichessCustomUriSchemeName`, `kLichessClientId`.
- *Refactor target*: Rename prefix `Lichess` to `App` or `Base` (e.g. `kAppHost`, `kAppClientId`).

### 4. Auth Repository (`lib/src/model/auth/auth_repository.dart`)
- Directly signs in via lichess.org OAuth PKCE.
- *Refactor target*: Parameterize endpoint calls through environmental variables or configure a clean dummy auth bypass option.

### 5. Extra Assets (`assets/images/`)
- `anon-engine.webp`, `anon-face.webp`, `broadcast_image.png`, `radio-tower.svg`.
- *Cleanup target*: Remove completely if they are not used by the core/showcase views.
