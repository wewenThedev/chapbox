import 'package:json_annotation/json_annotation.dart';

part 'user_notification.g.dart';

@JsonSerializable()
class UserNotification {
  int? userId; // Foreign key
  int? notificationId; // Foreign key
  DateTime? sentAt;

  UserNotification({this.userId, this.notificationId, this.sentAt});

  factory UserNotification.fromJson(Map<String, dynamic> json) => _$UserNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$UserNotificationToJson(this);
}
