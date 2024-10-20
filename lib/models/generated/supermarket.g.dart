// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../supermarket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supermarket _$SupermarketFromJson(Map<String, dynamic> json) => Supermarket(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      denomination: json['denomination'] as String?,
      rccm: json['rccm'] as String?,
      ifu: json['ifu'] as String?,
      website: json['website'] as String?,
      addressId: (json['addressId'] as num?)?.toInt(),
      logoId: (json['logoId'] as num?)?.toInt(),
      marketManagerId: (json['marketManagerId'] as num?)?.toInt(),
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

Map<String, dynamic> _$SupermarketToJson(Supermarket instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'denomination': instance.denomination,
      'rccm': instance.rccm,
      'ifu': instance.ifu,
      'website': instance.website,
      'addressId': instance.addressId,
      'logoId': instance.logoId,
      'marketManagerId': instance.marketManagerId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };
