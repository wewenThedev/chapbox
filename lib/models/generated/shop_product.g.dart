// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../shop_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopProduct _$ShopProductFromJson(Map<String, dynamic> json) => ShopProduct(
      shopId: (json['shopId'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShopProductToJson(ShopProduct instance) =>
    <String, dynamic>{
      'shopId': instance.shopId,
      'productId': instance.productId,
    };
