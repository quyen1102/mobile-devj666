import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nf_base/src/model/auth/auth_controller.dart';
import 'package:nf_base/src/model/user/user.dart';
import 'package:nf_base/src/network/aggregator.dart';
import 'package:nf_base/src/network/http.dart';

/// A provider that fetches the current user's account information.
final accountProvider = FutureProvider.autoDispose<User?>((Ref ref) {
  final authUser = ref.watch(authControllerProvider);
  if (authUser == null) return null;
  return ref.read(accountRepositoryProvider).getProfile();
}, name: 'AccountProvider');

/// A provider for the [AccountRepository].
final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  final client = ref.watch(lichessClientProvider);
  final aggregator = ref.watch(aggregatorProvider);
  return AccountRepository(client, aggregator);
}, name: 'AccountRepositoryProvider');

class AccountRepository {
  AccountRepository(this.client, this.aggregator);

  final LichessClient client;
  final Aggregator aggregator;

  Future<User> getProfile() {
    return aggregator.readJson(
      Uri(path: '/api/account'),
      atomicMapper: User.fromServerJson,
      aggregatedMapper: (json) => User.fromServerJson(json as Map<String, dynamic>),
    );
  }

  Future<void> saveProfile(Map<String, String> profile) async {
    final uri = Uri(path: '/account/profile');
    await client.postRead(uri, headers: {'Accept': 'application/json'}, body: profile);
  }
}
