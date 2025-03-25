// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoppingDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingDetails _$ShoppingDetailsFromJson(Map<String, dynamic> json) =>
    ShoppingDetails(
      id: (json['id'] as num).toInt(),
      cartId: (json['cart_id'] as num).toInt(),
      orderId: (json['order_id'] as num).toInt(),
      shopId: (json['shop_id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      addedAt: DateTime.parse(json['added_at'] as String),
      quantity: (json['quantity'] as num).toInt(),
      cost: (json['cost'] as num).toDouble(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
    );

Map<String, dynamic> _$ShoppingDetailsToJson(ShoppingDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cart_id': instance.cartId,
      'order_id': instance.orderId,
      'shop_id': instance.shopId,
      'product_id': instance.productId,
      'added_at': instance.addedAt.toIso8601String(),
      'quantity': instance.quantity,
      'cost': instance.cost,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      if (instance.deletedAt?.toIso8601String() case final value?)
        'deleted_at': value,
    };
