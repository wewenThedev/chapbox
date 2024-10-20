// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../shopping_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingDetails _$ShoppingDetailsFromJson(Map<String, dynamic> json) =>
    ShoppingDetails(
      id: (json['id'] as num?)?.toInt(),
      cartId: (json['cartId'] as num?)?.toInt(),
      shopId: (json['shopId'] as num?)?.toInt(),
      productId: (json['productId'] as num?)?.toInt(),
      addedAt: json['addedAt'] == null
          ? null
          : DateTime.parse(json['addedAt'] as String),
      quantity: (json['quantity'] as num?)?.toInt(),
      cost: (json['cost'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ShoppingDetailsToJson(ShoppingDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cartId': instance.cartId,
      'shopId': instance.shopId,
      'productId': instance.productId,
      'addedAt': instance.addedAt?.toIso8601String(),
      'quantity': instance.quantity,
      'cost': instance.cost,
    };
