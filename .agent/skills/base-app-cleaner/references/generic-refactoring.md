# Generic Refactoring Reference

This reference details the instructions for renaming and generalizing brand-specific classes, binders, and properties to make them project-agnostic.

## 1. Generalize Bindings

Identify any binding classes containing legacy brand names and rename them to a project-agnostic structure:

1. **Rename Binding Classes**:
   - Scan for classes containing `<Brand>Binding` (e.g., `MyBrandBinding`) and rename them to `AppBinding` or `BaseAppBinding`.
   - Rename concrete implementations (e.g., `App<Brand>Binding` to `AppDefaultBinding`).
   - Rename test mocks (e.g., `Test<Brand>Binding` to `TestAppBinding`).
2. **Rename Binding Initializers**:
   - Update static entry initializers (e.g., `App<Brand>Binding.ensureInitialized()` to `AppDefaultBinding.ensureInitialized()`).

## 2. Refactor Network Clients & Helpers

Generalize HTTP/WebSocket clients and domain-specific URI builders:

1. **Refactor HTTP Client**:
   - Rename brand-specific client classes and provider variables (e.g., `<Brand>Client` to `AppHttpClient`, `<brand>ClientProvider` to `appHttpClientProvider`).
   - Generalize base URI helper functions (e.g., `<brand>Uri` to `appUri`).
2. **Refactor WebSocket Client**:
   - Rename WebSocket event listeners, controllers, and URI builders (e.g., `<Brand>Socket` to `AppWebSocket`, `<brand>WSUri` to `appWSUri`).

## 3. Generalize Constants & Configuration

Replace legacy brand-branded constants with project-agnostic parameters:

1. **Rename Host Constants**:
   - Rename server base URLs and API client identifiers (e.g., `k<Brand>Host` to `kAppHost`, `k<Brand>ClientId` to `kAppClientId`).
2. **Rename Platform Properties**:
   - Rename native deep linking URI schemes (e.g., `k<Brand>CustomUriSchemeName` to `kAppCustomUriSchemeName`).
   - Update Android (`AndroidManifest.xml`) and iOS (`Info.plist`) scheme values to match.

## 4. Generalize Styles & Colors

Clean up custom styling extensions and names:

1. **Modify Custom Theme Extensions**:
   - Rename custom brand color classes (e.g., `<Brand>CustomColors` to `AppCustomColors`).
   - Rename global extension instances and getter extension methods (e.g., `context.<brand>Colors` to `context.appColors`).
