import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import 'package:nf_base/src/model/account/account_repository.dart';
import 'package:nf_base/src/model/user/user.dart';

/// A provider for [AccountService].
final accountServiceProvider = Provider<AccountService>((Ref ref) {
  final service = AccountService(ref);
  ref.onDispose(() {
    service.dispose();
  });
  return service;
}, name: 'AccountServiceProvider');

class AccountService {
  AccountService(this._ref);

  ProviderSubscription<AsyncValue<User?>>? _accountProviderSubscription;
  final Ref _ref;

  void start() {
    _accountProviderSubscription = _ref.listen(accountProvider, (_, account) {
      final username = account.value?.username ?? 'Guest';
      final now = DateTime.now();
      final lastUpdated = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      
      HomeWidget.saveWidgetData('username', username);
      HomeWidget.saveWidgetData('lastUpdated', lastUpdated);
      HomeWidget.updateWidget(iOSName: 'SampleDataWidget');
    });
  }

  void dispose() {
    _accountProviderSubscription?.close();
  }
}
