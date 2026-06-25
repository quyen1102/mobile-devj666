# State Management with Riverpod 3.x & Freezed

This document details the state management conventions and patterns used throughout the Base App. We use **Riverpod 3.x** for dependency injection and state management, combined with **Freezed** for immutable data modeling and union types.

## Core Rules

1. **Keep states immutable**: Always use Freezed classes for non-trivial states.
2. **Prefer Notifier / AsyncNotifier**: Use class-based notifier providers instead of legacy state providers or state notifier providers.
3. **Use Code Generation**: Always let `build_runner` generate boilerplate (`.freezed.dart`, `.g.dart`) for type safety and serialization.

## Notifier Pattern (Synchronous State)

For local synchronous states (e.g. settings preferences, simple toggles):

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_settings.freezed.dart';

@freezed
class ThemeSettingsState with _$ThemeSettingsState {
  const factory ThemeSettingsState({
    required bool isDarkMode,
    @Default(0xFF2196F3) int seedColor,
  }) = _ThemeSettingsState;
}

final themeSettingsProvider = NotifierProvider<ThemeSettingsNotifier, ThemeSettingsState>(
  ThemeSettingsNotifier.new,
);

class ThemeSettingsNotifier extends Notifier<ThemeSettingsState> {
  @override
  ThemeSettingsState build() {
    return const ThemeSettingsState(isDarkMode: false);
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }
}
```

## AsyncNotifier Pattern (Asynchronous State)

For asynchronous states like data fetching, remote API calls, or socket connections:

```dart
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_controller.freezed.dart';

@freezed
class ConversationState with _$ConversationState {
  const factory ConversationState({
    required List<Message> messages,
    @Default(false) bool isTyping,
  }) = _ConversationState;
}

final conversationControllerProvider = AsyncNotifierProvider.autoDispose
    .family<ConversationController, ConversationState, String>(
  ConversationController.new,
);

class ConversationController extends AutoDisposeFamilyAsyncNotifier<ConversationState, String> {
  @override
  Future<ConversationState> build(String arg) async {
    // Arg is the parameters passed to the family (e.g., UserId)
    final messages = await ref.read(messageRepositoryProvider).loadMessages(arg);
    return ConversationState(messages: messages);
  }

  Future<void> sendMessage(String text) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final response = await ref.read(messageRepositoryProvider).postMessage(arg, text);
      final updatedMessages = [response, ...state.value!.messages];
      return state.value!.copyWith(messages: updatedMessages);
    });
  }
}
```

## Consuming Providers in Widgets

Always use `ConsumerWidget` or `ConsumerStatefulWidget` to read providers.

```dart
class ConversationScreen extends ConsumerWidget {
  final String userId;
  const ConversationScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(conversationControllerProvider(userId));

    return Scaffold(
      body: stateAsync.when(
        data: (state) => ListView(
          children: state.messages.map((m) => Text(m.text)).toList(),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
```
