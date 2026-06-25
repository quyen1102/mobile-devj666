import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nf_base/src/model/common/id.dart';
import 'package:nf_base/src/model/message/message_repository.dart';
import 'package:nf_base/src/model/notifications/notification_service.dart';
import 'package:nf_base/src/model/notifications/notifications.dart';
import 'package:nf_base/src/tab_scaffold.dart';
import 'package:nf_base/src/view/message/conversation_screen.dart';
import 'package:nf_base/src/model/user/user.dart';

/// A provider for [MessageService].
final messageServiceProvider = Provider<MessageService>((Ref ref) {
  final service = MessageService(ref);
  ref.onDispose(service.dispose);
  return service;
}, name: 'MessageServiceProvider');

class MessageService {
  MessageService(this.ref);

  final Ref ref;

  StreamSubscription<ParsedLocalNotification>? _notificationResponseSubscription;
  StreamSubscription<ReceivedFcmMessage>? _fcmSubscription;

  void start() {
    _fcmSubscription = NotificationService.fcmMessageStream.listen((data) {
      final (message: fcmMessage, fromBackground: fromBackground) = data;
      switch (fcmMessage) {
        case NewMessageFcmMessage():
          ref.invalidate(contactsProvider);
          ref.invalidate(unreadMessagesProvider);
        case _:
          break;
      }
    });

    _notificationResponseSubscription = NotificationService.responseStream.listen((data) {
      final (_, notification) = data;
      switch (notification) {
        case NewMessageNotification(:final conversationId):
          _onNotificationResponse(conversationId);
        case _:
          break;
      }
    });
  }

  /// Handles a notification response that caused the app to open.
  Future<void> _onNotificationResponse(UserId conversationId) async {
    final context = ref.read(currentNavigatorKeyProvider).currentContext;
    if (context == null || !context.mounted) return;

    final rootNavState = Navigator.of(context, rootNavigator: true);
    if (rootNavState.canPop()) {
      rootNavState.popUntil((route) => route.isFirst);
    }

    Navigator.of(
      context,
      rootNavigator: true,
    ).push(
      ConversationScreen.buildRoute(
        user: LightUser(id: conversationId, name: conversationId.value),
      ),
    );
  }

  void dispose() {
    _fcmSubscription?.cancel();
    _notificationResponseSubscription?.cancel();
  }
}
