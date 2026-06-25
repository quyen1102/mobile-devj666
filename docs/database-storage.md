# Local Database & Secure Storage Guide

The Base App provides two layers of local persistence:
1. **SQLite Database (`sqflite`)**: For structured, queryable data, offline sync tables, and performance logging.
2. **Secure Storage (`flutter_secure_storage`)**: For sensitive data like authentication tokens, passwords, and API credentials.

---

## SQLite Database Setup

Managed under `lib/src/db/database.dart`, the sqlite system features database migrations, automated old record pruning (TTL), and Write-Ahead Logging (WAL) configuration.

### Providers & Initialization
The database instance is exposed asynchronously via Riverpod's `databaseProvider`:

```dart
final db = await ref.watch(databaseProvider.future);
```

### Table Definitions & Schema
Currently, the database version is **5** and initializes tables for:
- `http_log`: Logs network requests, response codes, and errors (pruned after 7 days).
- `app_log`: Session logging errors and warnings (pruned after 7 days).

### Automatic Pruning (TTL)
On database startup (`onOpen`), a transaction is run to delete entries older than their TTL:
```dart
const httpLogTTL = Duration(days: 7);
const appLogTTL = Duration(days: 7);
```

### Best Practices for DB Updates
When adding new tables or columns:
1. Increment the `version` inside `openAppDatabase` options.
2. Write corresponding migrations inside `onUpgrade` based on `oldVersion`.
3. Add table drop/creation code inside `onCreate` to ensure fresh installs build correctly.

---

## Secure Storage

Sensitive credentials are saved using native keychain/keystore APIs wrapped under `SecureStorage` (`lib/src/db/secure_storage.dart`).

### Storage Namespace
Android options use the namespace: `org.lichess.mobile.secure`.

### Standard Usage Pattern
Always access secure storage using the static singleton `SecureStorage.instance`:

```dart
// Writing data:
await SecureStorage.instance.write(key: 'auth_token', value: token);

// Reading data:
final token = await SecureStorage.instance.read(key: 'auth_token');

// Deleting data:
await SecureStorage.instance.delete(key: 'auth_token');
```

Refer to `lib/src/model/auth/auth_storage.dart` for concrete authentication-specific read/write methods.
