// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      guestFirstname: json['guest_firstname'] as String?,
      guestLastname: json['guest_lastname'] as String?,
      guestPhone: json['guest_phone'] as String?,
      guestEmail: json['guest_email'] as String?,
      totalHt: (json['total_ht'] as num).toDouble(),
      totalTtc: (json['total_ttc'] as num).toDouble(),
      orderingDate: DateTime.parse(json['ordering_date'] as String),
      shippingDate: json['shipping_date'] == null
          ? null
          : DateTime.parse(json['shipping_date'] as String),
      recoveryMode: $enumDecodeNullable(
              _$RecoveryModeEnumMap, json['recovery_mode'],
              unknownValue: RecoveryMode.delivery) ??
          RecoveryMode.delivery,
      shippingAddress: json['shipping_address'] as String?,
      status: $enumDecodeNullable(_$OrderStatusEnumMap, json['status'],
              unknownValue: OrderStatus.pending) ??
          OrderStatus.pending,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      if (instance.guestFirstname case final value?) 'guest_firstname': value,
      if (instance.guestLastname case final value?) 'guest_lastname': value,
      if (instance.guestPhone case final value?) 'guest_phone': value,
      if (instance.guestEmail case final value?) 'guest_email': value,
      'total_ht': instance.totalHt,
      'total_ttc': instance.totalTtc,
      'ordering_date': instance.orderingDate.toIso8601String(),
      if (instance.shippingDate?.toIso8601String() case final value?)
        'shipping_date': value,
      'recovery_mode': _$RecoveryModeEnumMap[instance.recoveryMode]!,
      if (instance.shippingAddress case final value?) 'shipping_address': value,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      if (instance.deletedAt?.toIso8601String() case final value?)
        'deleted_at': value,
    };

const _$RecoveryModeEnumMap = {
  RecoveryMode.pickup: 'pickup',
  RecoveryMode.delivery: 'delivery',
};

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.processing: 'processing',
  OrderStatus.failed: 'failed',
  OrderStatus.successful: 'successful',
  OrderStatus.canceled: 'canceled',
};
