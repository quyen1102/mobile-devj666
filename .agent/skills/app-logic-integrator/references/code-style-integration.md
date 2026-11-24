# Code Style & Riverpod Integration

Integrate app logic matching codebase styles, state management, and file size limits.

## State Management (Riverpod 3.x)
- Use Riverpod generators to define providers (e.g. `@riverpod` notifier classes or functions).
- Keep state logic separate from UI views. Expose state through providers, and watch them inside `ConsumerWidget` or `ConsumerStatefulWidget` build methods.
- Write mockable services. If calling APIs or writing to disk, inject dependency providers (e.g. using `httpClientFactoryProvider` override or preferences providers) so they can be mocked in tests.

## File Size Limits & Modularization
- Keep individual code files under **200 lines**.
- If a code file grows larger, split it into smaller components/services (e.g., extract sub-widgets, separate database/prefs storage into service classes).
- Use composition rather than inheritance.
- Use kebab-case file names that are self-documenting.

## Immutability & Code Gen
- Use `Freezed` for defining model classes.
- Use `fast_immutable_collections` (`IList`, `IMap`) in all public API/provider signatures to prevent accidental mutation of collections.
- Run `dart run build_runner build` after modifying files with code-generation tags (e.g. `@freezed`, `@riverpod`).

## Related Documentation

- [Coding Style Guide](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/docs/coding_style.md)
- [State Management with Riverpod 3.x & Freezed](file:///Users/devj666/Documents/WorkPlace/Personal/mobile-devj666/docs/state-management.md)

