import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nf_base/src/binding.dart';
import 'package:nf_base/src/model/auth/auth_controller.dart';
import 'package:nf_base/src/model/user/user.dart';
import 'package:logging/logging.dart';

final _logger = Logger('PreferencesStorage');

abstract class Serializable {
  Map<String, dynamic> toJson();
}

/// A preference category with its storage key
enum PrefCategory {
  general('preferences.general'),
  log('preferences.log');

  const PrefCategory(this.storageKey);

  final String storageKey;
}

/// A [Notifier] mixin to provide a way to store and retrieve preferences.
mixin PreferencesStorage<T extends Serializable> on Notifier<T> {
  T fromJson(Map<String, dynamic> json);
  T get defaults;

  PrefCategory get prefCategory;

  Future<void> save(T value) async {
    await BaseAppBinding.instance.sharedPreferences.setString(
      prefCategory.storageKey,
      jsonEncode(value.toJson()),
    );

    state = value;
  }

  T fetch() {
    final stored = BaseAppBinding.instance.sharedPreferences.getString(prefCategory.storageKey);
    if (stored == null) {
      return defaults;
    }
    try {
      return fromJson(jsonDecode(stored) as Map<String, dynamic>);
    } catch (e) {
      _logger.warning('Failed to decode $prefCategory preferences: $e');
      return defaults;
    }
  }
}

/// A [Notifier] mixin to provide a way to store and retrieve preferences per authUser.
mixin SessionPreferencesStorage<T extends Serializable> on Notifier<T> {
  T fromJson(Map<String, dynamic> json);
  T defaults({LightUser? user});

  PrefCategory get prefCategory;

  Future<void> save(T value) async {
    final authUser = ref.read(authControllerProvider);
    await BaseAppBinding.instance.sharedPreferences.setString(
      key(prefCategory.storageKey, authUser),
      jsonEncode(value.toJson()),
    );

    state = value;
  }

  T fetch() {
    final authUser = ref.watch(authControllerProvider);
    final stored = BaseAppBinding.instance.sharedPreferences.getString(
      key(prefCategory.storageKey, authUser),
    );
    if (stored == null) {
      return defaults(user: authUser?.user);
    }
    try {
      return fromJson(jsonDecode(stored) as Map<String, dynamic>);
    } catch (e) {
      _logger.warning('Failed to decode $prefCategory preferences: $e');
      return defaults(user: authUser?.user);
    }
  }

  static String key(String key, AuthUser? authUser) => '$key.${authUser?.user.id ?? '**anon**'}';
}
