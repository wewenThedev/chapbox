// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) => Shop(
      id: (json['id'] as num?)?.toInt(),
      city: json['city'] as String?,
      phone: json['phone'] as String?,
      addressId: (json['addressId'] as num?)?.toInt(),
      supermarketId: (json['supermarketId'] as num?)?.toInt(),
      shopManagerId: (json['shopManagerId'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'phone': instance.phone,
      'addressId': instance.addressId,
      'supermarketId': instance.supermarketId,
      'shopManagerId': instance.shopManagerId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };
