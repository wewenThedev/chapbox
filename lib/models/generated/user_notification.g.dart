// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotification _$UserNotificationFromJson(Map<String, dynamic> json) =>
    UserNotification(
      userId: (json['userId'] as num?)?.toInt(),
      notificationId: (json['notificationId'] as num?)?.toInt(),
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
    );

Map<String, dynamic> _$UserNotificationToJson(UserNotification instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'notificationId': instance.notificationId,
      'sentAt': instance.sentAt?.toIso8601String(),
    };
