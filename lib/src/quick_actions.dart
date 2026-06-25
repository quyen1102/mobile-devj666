import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_actions/quick_actions.dart';

/// Provider for the [QuickActionService].
final quickActionServiceProvider = Provider<QuickActionService>((Ref ref) {
  return QuickActionService(ref);
}, name: 'QuickActionServiceProvider');

class QuickActionService {
  QuickActionService(this.ref);

  final Ref ref;
  final QuickActions quickActions = const QuickActions();

  TargetPlatform get platform => defaultTargetPlatform;

  void start() {
    quickActions.initialize((String shortcutType) {
      debugPrint('Quick action triggered: $shortcutType');
      // Add custom quick action handling logic here
    });
    setQuickActions();
  }

  void setQuickActions() {
    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
        type: 'open_home',
        localizedTitle: 'Home',
        icon: platform == TargetPlatform.iOS ? 'HomeIcon' : 'home',
      ),
    ]);
  }
}
