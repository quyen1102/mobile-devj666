# State Management Patterns

Uses **Riverpod 3.x** + **Freezed**. See `lib/src/model/` for all providers.

## Critical Riverpod 3.x API Notes

- `AsyncValue<T>.value` returns `T?` (null when loading/error). **`valueOrNull` does NOT exist.**
- Do NOT use `ProviderListenable<T>` as type annotation — it is internal.
- `ref.listenManual<T?>` requires explicit type when selecting nullable values.

## Synchronous State (Notifier)

```dart
@freezed
class MyFeatureState with _$MyFeatureState {
  const factory MyFeatureState({
    required String value,
    @Default(false) bool isEditing,
  }) = _MyFeatureState;
}

final myFeatureProvider = NotifierProvider<MyFeatureNotifier, MyFeatureState>(
  MyFeatureNotifier.new,
);

class MyFeatureNotifier extends Notifier<MyFeatureState> {
  @override
  MyFeatureState build() => const MyFeatureState(value: '');

  void update(String value) {
    state = state.copyWith(value: value);
  }
}
```

## Async State (AsyncNotifier)

```dart
@freezed
class MyFeatureState with _$MyFeatureState {
  const factory MyFeatureState({
    required List<Item> items,
    @Default(false) bool isLoading,
  }) = _MyFeatureState;
}

final myFeatureProvider = AsyncNotifierProvider.autoDispose
    .family<MyFeatureNotifier, MyFeatureState, String>(
  MyFeatureNotifier.new,
);

class MyFeatureNotifier extends AutoDisposeFamilyAsyncNotifier<MyFeatureState, String> {
  @override
  Future<MyFeatureState> build(String id) async {
    final items = await ref.read(myRepositoryProvider).getItems(id);
    return MyFeatureState(items: items);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build(arg));
  }
}
```

## Consuming in Widgets

```dart
class MyScreen extends ConsumerWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(myFeatureProvider('someId'));

    return stateAsync.when(
      data: (state) => ListView(...),
      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
```

## HTTP Mocking in Tests

**Always mock at HTTP layer** — do NOT override Riverpod providers directly for network providers:

```dart
overrides: [
  httpClientFactoryProvider.overrideWith((ref) {
    return FakeHttpClientFactory(
      () => MockClient((request) async {
        if (request.url.path == '/api/my-endpoint') {
          return http.Response(mockResponseJson, 200);
        }
        return http.Response('', 404);
      }),
    );
  }),
],
```

Direct provider overrides OK only for **non-network providers** (no `keepAlive`, no skip of real logic).

## Repository Pattern

```dart
class MyRepository {
  MyRepository({required this.httpClient});

  final http.Client httpClient;

  Future<List<Item>> getItems(String id) async {
    final uri = lichessUri('/api/items/$id');
    final response = await httpClient.get(uri);
    // parse response...
  }
}

final myRepositoryProvider = Provider<MyRepository>((ref) {
  return MyRepository(httpClient: ref.watch(httpClientProvider));
});
```

## Settings Persistence

Settings use `SharedPreferences` via `LichessBinding.instance.sharedPreferences`.  
Extend `GeneralPrefs` in `lib/src/model/settings/general_preferences.dart` for app-wide prefs.

## Immutability Rules

- All model fields must be `final` or `late final`
- Use `@freezed` classes for all data models
- Use `IList`/`IMap` from `fast_immutable_collections` in public APIs
- Standard `List`/`Map` allowed only in local function scope
