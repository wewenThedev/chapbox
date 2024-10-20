// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../paymentMethod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    PaymentMethod(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      logoId: (json['logoId'] as num?)?.toInt(),
      termsConditions: json['termsConditions'] as String?,
      fees: (json['fees'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'logoId': instance.logoId,
      'termsConditions': instance.termsConditions,
      'fees': instance.fees,
    };
