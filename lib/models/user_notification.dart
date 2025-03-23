import 'package:json_annotation/json_annotation.dart';
import 'package:chapbox/models/user.dart';
import 'package:chapbox/models/notification.dart';

part 'user_notification.g.dart';
//part 'generated/user_notification.g.dart';

@JsonSerializable(explicitToJson: true)
class UserNotification {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'notification_id')
  final int notificationId;

  @JsonKey(name: 'sent_at', includeIfNull: false)
  final DateTime? sentAt;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  // Relations
  @JsonKey(ignore: true)
  User? user;

  @JsonKey(ignore: true)
  Notification? notification;

  UserNotification({
    required this.userId,
    required this.notificationId,
    this.sentAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.user,
    this.notification,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    final userNotification = _$UserNotificationFromJson(json);

    // Hydrate les relations si présentes dans le JSON
    if (json['notification'] != null) {
      userNotification.notification =
          Notification.fromJson(json['notification']);
    }

    if (json['user'] != null) {
      userNotification.user = User.fromJson(json['user']);
    }

    return userNotification;
  }

  Map<String, dynamic> toJson() => _$UserNotificationToJson(this);

  // Helper pour vérifier si la notification a été envoyée
  bool get isSent => sentAt != null;
}
