// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopMedia.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopMedia _$ShopMediaFromJson(Map<String, dynamic> json) => ShopMedia(
      shopId: (json['shop_id'] as num).toInt(),
      mediaId: (json['media_id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
    );

Map<String, dynamic> _$ShopMediaToJson(ShopMedia instance) => <String, dynamic>{
      'shop_id': instance.shopId,
      'media_id': instance.mediaId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      if (instance.deletedAt?.toIso8601String() case final value?)
        'deleted_at': value,
    };
