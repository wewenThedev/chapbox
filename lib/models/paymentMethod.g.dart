// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentMethod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    PaymentMethod(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      logoId: (json['logo_id'] as num?)?.toInt(),
      termsConditions: json['terms_conditions'] as String?,
      fees: (json['fees'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
    );

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.description case final value?) 'description': value,
      if (instance.logoId case final value?) 'logo_id': value,
      if (instance.termsConditions case final value?) 'terms_conditions': value,
      if (instance.fees case final value?) 'fees': value,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      if (instance.deletedAt?.toIso8601String() case final value?)
        'deleted_at': value,
    };
