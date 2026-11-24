# Adding a New Feature View

Step-by-step guide for adding a new screen/feature to this base app.

## Directory Convention

```
lib/src/
├── model/
│   └── {feature}/
│       ├── {feature}_state.dart       # Freezed state class
│       ├── {feature}_controller.dart  # AsyncNotifier/Notifier
│       └── {feature}_repository.dart  # Data fetching
└── view/
    └── {feature}/
        ├── {feature}_screen.dart      # Main screen widget
        └── {feature}_list_item.dart   # Reusable sub-widget (if needed)
```

Keep each file under **200 lines**. Split into sub-widgets if needed.

## Step 1: Define the Model

```dart
// lib/src/model/my_feature/my_feature_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

part 'my_feature_state.freezed.dart';

@freezed
class MyFeatureState with _$MyFeatureState {
  const factory MyFeatureState({
    required IList<MyItem> items,
    @Default(false) bool isRefreshing,
  }) = _MyFeatureState;
}
```

Run: `dart run build_runner build`

## Step 2: Create the Repository

```dart
// lib/src/model/my_feature/my_feature_repository.dart
import 'package:nf_base/src/network/http.dart';

class MyFeatureRepository {
  MyFeatureRepository({required this.client});

  final LichessClient client;

  Future<IList<MyItem>> fetchItems() async {
    return client.readJson(lichessUri('/api/my-feature'), mapper: (json) {
      // parse JSON...
    });
  }
}
```

## Step 3: Create the Controller

```dart
// lib/src/model/my_feature/my_feature_controller.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_feature_controller.g.dart';

@riverpod
class MyFeatureController extends _$MyFeatureController {
  @override
  Future<MyFeatureState> build() async {
    final repo = ref.watch(myFeatureRepositoryProvider);
    final items = await repo.fetchItems();
    return MyFeatureState(items: items);
  }
}
```

## Step 4: Create the Screen

```dart
// lib/src/view/my_feature/my_feature_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nf_base/src/widgets/platform.dart';
import 'package:nf_base/src/styles/styles.dart';

class MyFeatureScreen extends ConsumerWidget {
  const MyFeatureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(myFeatureControllerProvider);

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('My Feature'),
      ),
      body: stateAsync.when(
        data: (state) => _FeatureContent(state: state),
        loading: () => const Center(child: CircularProgressIndicator.adaptive()),
        error: (err, _) => Center(
          child: Text('Could not load feature', style: Styles.noResultTextStyle),
        ),
      ),
    );
  }
}

class _FeatureContent extends StatelessWidget {
  const _FeatureContent({required this.state});

  final MyFeatureState state;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: Styles.verticalBodyPadding,
      itemCount: state.items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, i) => _ItemTile(item: state.items[i]),
    );
  }
}
```

## Step 5: Register Navigation

### Option A: Push from existing screen
```dart
Navigator.of(context).push(
  MaterialPageRoute(builder: (_) => const MyFeatureScreen()),
);
```

### Option B: Add as a new tab
See `references/navigation-tab-shell.md` → "Adding a New Tab".

### Option C: Add to Home screen dashboard
Add a card/tile in `lib/src/view/home/home_tab_screen.dart`.

## UI Rules Checklist

- [ ] Use `PlatformScaffold` + `PlatformAppBar` (not raw `Scaffold`/`AppBar`)
- [ ] Use `Styles.*` spacing/typography constants
- [ ] Use `Theme.of(context).colorScheme.*` or `context.lichessColors.*` for all colors
- [ ] Use `CircularProgressIndicator.adaptive()` for loading states
- [ ] Use `StatelessWidget` for reusable sub-widgets (not functions returning widgets)
- [ ] Prefer `collection if` / `collection for` over imperative list building
- [ ] All model fields are `final` (immutable)
- [ ] Run `flutter analyze` and `dart format path/to/file.dart` after editing

## Replacing Business Logic

The base provides UI shell. To swap business logic:
1. Keep the same `View` structure and widget patterns
2. Replace `Repository` with new data source / API calls
3. Adapt `State` model fields to new domain
4. Keep `Controller` pattern (AsyncNotifier/Notifier)
5. Reuse all widgets from `lib/src/widgets/` as-is
