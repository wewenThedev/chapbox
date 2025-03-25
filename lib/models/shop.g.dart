// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) => Shop(
      id: (json['id'] as num).toInt(),
      city: json['city'] as String,
      phone: json['phone'] as String,
      addressId: (json['address_id'] as num).toInt(),
      supermarketId: (json['supermarket_id'] as num).toInt(),
      shopManagerId: (json['shop_manager_id'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'phone': instance.phone,
      'address_id': instance.addressId,
      'supermarket_id': instance.supermarketId,
      'shop_manager_id': instance.shopManagerId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      if (instance.deletedAt?.toIso8601String() case final value?)
        'deleted_at': value,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'products': instance.products?.map((e) => e.toJson()).toList(),
    };
