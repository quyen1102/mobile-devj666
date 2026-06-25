import 'package:deep_pick/deep_pick.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nf_base/l10n/l10n.dart';
import 'package:nf_base/src/model/common/id.dart';
import 'package:meta/meta.dart';

/// FCM Messages
///////////////

/// Parsed data from an FCM message.
@immutable
sealed class FcmMessage {
  const FcmMessage();

  RemoteNotification? get notification;

  factory FcmMessage.fromRemoteMessage(RemoteMessage message) {
    final messageType = message.data['app.type'] as String?;

    if (messageType == null) {
      return UnhandledFcmMessage(message.data);
    } else {
      switch (messageType) {
        case 'newMessage':
          final conversationId = message.data['app.threadId'] as String?;
          if (conversationId != null) {
            return NewMessageFcmMessage(UserId(conversationId), notification: message.notification);
          } else {
            return MalformedFcmMessage(message.data);
          }
        default:
          return UnhandledFcmMessage(message.data);
      }
    }
  }
}

/// An [FcmMessage] that represents a new message.
@immutable
class NewMessageFcmMessage extends FcmMessage {
  const NewMessageFcmMessage(this.conversationId, {required this.notification});

  final UserId conversationId;

  @override
  final RemoteNotification? notification;

  @override
  String toString() => 'NewMessageFcmMessage(conversationId: $conversationId)';
}

/// An [FcmMessage] that could not be parsed.
@immutable
class MalformedFcmMessage extends FcmMessage {
  const MalformedFcmMessage(this.data);

  final Map<String, dynamic> data;

  @override
  RemoteNotification? get notification => null;
}

/// An [FcmMessage] that is not handled by the application.
@immutable
class UnhandledFcmMessage extends FcmMessage {
  const UnhandledFcmMessage(this.data);

  final Map<String, dynamic> data;

  @override
  RemoteNotification? get notification => null;
}

/// Local Notifications
///////////////////////

/// A notification shown to the user from the platform's notification system.
@immutable
sealed class LocalNotification {
  const LocalNotification();

  /// The unique identifier of the notification.
  int get id;

  /// The channel identifier of the notification.
  String get channelId;

  /// The localized title of the notification.
  String title(AppLocalizations l10n);

  /// The localized body of the notification.
  String? body(AppLocalizations l10n);

  /// The payload of the notification.
  Map<String, dynamic> get payload => {'channel': channelId, ..._concretePayload};

  /// The actual payload of the notification.
  Map<String, dynamic> get _concretePayload;

  /// The localized details of the notification for each platform.
  NotificationDetails details(AppLocalizations l10n);

  /// Retrieves a local notification from a JSON payload.
  factory LocalNotification.fromJson(Map<String, dynamic> json) {
    final channel = json['channel'] as String;
    switch (channel) {
      case 'newMessage':
        return NewMessageNotification.fromJson(json);
      case 'announce':
        return AnnounceNotification.fromJson(json);
      default:
        throw ArgumentError('Unknown notification channel: $channel');
    }
  }
}

/// A notification for a new message.
class NewMessageNotification extends LocalNotification {
  const NewMessageNotification(this.conversationId, String title, String message)
    : _title = title,
      _message = message;

  final UserId conversationId;
  final String _title;
  final String _message;

  factory NewMessageNotification.fromJson(Map<String, dynamic> json) {
    final conversationId = UserId.fromJson(json['conversationId'] as String);
    final title = json['title'] as String;
    final message = json['message'] as String;
    return NewMessageNotification(conversationId, title, message);
  }

  factory NewMessageNotification.fromFcmMessage(NewMessageFcmMessage message) {
    return NewMessageNotification(
      message.conversationId,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
    );
  }

  @override
  String get channelId => 'newMessage';

  @override
  int get id => conversationId.hashCode;

  @override
  Map<String, dynamic> get _concretePayload => {
    'conversationId': conversationId.toJson(),
    'title': _title,
    'message': _message,
  };

  @override
  String title(AppLocalizations l10n) => _title;

  @override
  String body(AppLocalizations _) => _message;

  @override
  NotificationDetails details(AppLocalizations l10n) => NotificationDetails(
    android: AndroidNotificationDetails(
      channelId,
      'Messages',
      importance: Importance.max,
      priority: Priority.high,
      autoCancel: true,
    ),
    iOS: DarwinNotificationDetails(threadIdentifier: channelId),
  );
}

/// A notification for an announcement.
class AnnounceNotification extends LocalNotification {
  const AnnounceNotification(this.message, {this.date});

  final String message;
  final DateTime? date;

  static const String dismissActionId = 'dismiss';
  static const int notificationId = 12345;

  @override
  String get channelId => 'announce';

  @override
  int get id => notificationId;

  @override
  Map<String, dynamic> get _concretePayload => {
    'message': message,
    if (date != null) 'date': date!.toIso8601String(),
  };

  @override
  String title(AppLocalizations l10n) => 'Announcement';

  @override
  String body(AppLocalizations _) => message;

  @override
  NotificationDetails details(AppLocalizations l10n) => NotificationDetails(
    android: AndroidNotificationDetails(
      channelId,
      'Announcements',
      importance: Importance.max,
      priority: Priority.high,
      autoCancel: true,
      actions: [
        AndroidNotificationAction(
          dismissActionId,
          'Dismiss',
          cancelNotification: true,
        ),
      ],
    ),
    iOS: DarwinNotificationDetails(
      threadIdentifier: channelId,
      categoryIdentifier: channelId,
    ),
  );

  factory AnnounceNotification.fromJson(Map<String, dynamic> json) {
    final message = json['message'] as String;
    final dateStr = json['date'] as String?;
    final date = dateStr != null ? DateTime.tryParse(dateStr) : null;
    return AnnounceNotification(message, date: date);
  }
}
