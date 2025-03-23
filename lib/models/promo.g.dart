// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promo _$PromoFromJson(Map<String, dynamic> json) => Promo(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      description: json['description'] as String?,
      type: $enumDecode(_$PromoTypeEnumMap, json['type'],
          unknownValue: PromoType.other),
      supermarketId: (json['supermarket_id'] as num?)?.toInt(),
      discount: (json['discount'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
    );

Map<String, dynamic> _$PromoToJson(Promo instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      if (instance.description case final value?) 'description': value,
      'type': _$PromoTypeEnumMap[instance.type]!,
      if (instance.supermarketId case final value?) 'supermarket_id': value,
      'discount': instance.discount,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      if (instance.deletedAt?.toIso8601String() case final value?)
        'deleted_at': value,
    };

const _$PromoTypeEnumMap = {
  PromoType.percentage: 'percentage',
  PromoType.fixed: 'fixed',
  PromoType.free_shipping: 'free_shipping',
  PromoType.other: 'other',
};
