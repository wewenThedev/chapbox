// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopProduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopProduct _$ShopProductFromJson(Map<String, dynamic> json) => ShopProduct(
      shopId: (json['shop_id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      fullName: json['fullName'] as String?,
    );

Map<String, dynamic> _$ShopProductToJson(ShopProduct instance) =>
    <String, dynamic>{
      'shop_id': instance.shopId,
      'product_id': instance.productId,
      'price': instance.price,
      'stock': instance.stock,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      if (instance.deletedAt?.toIso8601String() case final value?)
        'deleted_at': value,
      'fullName': instance.fullName,
    };
