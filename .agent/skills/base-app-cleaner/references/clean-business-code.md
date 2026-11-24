# Clean Business Code Reference

This reference details the instructions for purging domain-specific models, view components, and database schemas from the application shell.

## 1. Purge Domain Directories

Identify and delete directories implementing legacy application business logic:

1. **Delete Business Logic Models**:
   - Locate your state models directory (typically `lib/src/model/` or `lib/models/`).
   - Delete folders containing domain-specific state managers, providers, or data models.
2. **Delete View Screens**:
   - Locate your view/UI screens directory (typically `lib/src/view/` or `lib/views/` or `lib/screens/`).
   - Delete directories containing layouts, pages, or components specific to legacy workflows.

## 2. Refactor Scaffold & Entry Points

Update navigation containers, routers, and application entry points:

1. **Modify the Main Navigation Scaffold / Router**:
   - Strip out any references to the deleted legacy views.
   - Configure basic generic tabs (e.g., Dashboard/Home, Settings, Account).
   - Update icons and titles in bottom navigation bars, side drawers, or routers to match the generic layout.
2. **Modify the Main Application Widget**:
   - Remove background service initializations or controllers that are specific to the legacy domain.
   - Retain or adapt general-purpose controllers (e.g., auth service, notification listener, settings manager).
3. **Modify Application Bootstrap / Initializers**:
   - Remove custom engine, database, or API wrappers initialization logic.
   - Clean up dependency injection setup or startup initialization flags.
