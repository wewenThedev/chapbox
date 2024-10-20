// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../shop_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopMedia _$ShopMediaFromJson(Map<String, dynamic> json) => ShopMedia(
      shopId: (json['shopId'] as num?)?.toInt(),
      mediaId: (json['mediaId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShopMediaToJson(ShopMedia instance) => <String, dynamic>{
      'shopId': instance.shopId,
      'mediaId': instance.mediaId,
    };
