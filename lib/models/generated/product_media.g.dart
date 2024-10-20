// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../product_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductMedia _$ProductMediaFromJson(Map<String, dynamic> json) => ProductMedia(
      productId: (json['productId'] as num?)?.toInt(),
      mediaId: (json['mediaId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductMediaToJson(ProductMedia instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'mediaId': instance.mediaId,
    };
