// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../promo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promo _$PromoFromJson(Map<String, dynamic> json) => Promo(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      supermarketId: (json['supermarketId'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PromoToJson(Promo instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'description': instance.description,
      'type': instance.type,
      'supermarketId': instance.supermarketId,
      'discount': instance.discount,
    };
