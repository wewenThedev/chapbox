// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback(
      id: (json['id'] as num?)?.toInt(),
      score: (json['score'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      orderId: (json['orderId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'id': instance.id,
      'score': instance.score,
      'comment': instance.comment,
      'orderId': instance.orderId,
    };
