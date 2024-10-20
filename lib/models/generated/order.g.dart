// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num?)?.toInt(),
      shoppingDetailsId: (json['shoppingDetailsId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      guestFirstname: json['guestFirstname'] as String?,
      guestLastname: json['guestLastname'] as String?,
      guestPhone: json['guestPhone'] as String?,
      guestEmail: json['guestEmail'] as String?,
      totalHt: (json['totalHt'] as num?)?.toDouble(),
      totalTtc: (json['totalTtc'] as num?)?.toDouble(),
      orderingDate: json['orderingDate'] == null
          ? null
          : DateTime.parse(json['orderingDate'] as String),
      shippingDate: json['shippingDate'] == null
          ? null
          : DateTime.parse(json['shippingDate'] as String),
      shippingAddress: json['shippingAddress'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'shoppingDetailsId': instance.shoppingDetailsId,
      'userId': instance.userId,
      'guestFirstname': instance.guestFirstname,
      'guestLastname': instance.guestLastname,
      'guestPhone': instance.guestPhone,
      'guestEmail': instance.guestEmail,
      'totalHt': instance.totalHt,
      'totalTtc': instance.totalTtc,
      'orderingDate': instance.orderingDate?.toIso8601String(),
      'shippingDate': instance.shippingDate?.toIso8601String(),
      'shippingAddress': instance.shippingAddress,
      'status': instance.status,
    };
