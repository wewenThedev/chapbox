// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      orderId: (json['order_id'] as num).toInt(),
      methodId: (json['method_id'] as num).toInt(),
      paidAt: json['paid_at'] == null
          ? null
          : DateTime.parse(json['paid_at'] as String),
      status: $enumDecode(_$PaymentStatusEnumMap, json['status'],
          unknownValue: PaymentStatus.processing),
      codePromoId: (json['code_promo_id'] as num?)?.toInt(),
      totalPaid: (json['total_paid'] as num).toDouble(),
      details: json['details'] as String?,
      invoiceId: (json['invoice_id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'order_id': instance.orderId,
      'method_id': instance.methodId,
      if (instance.paidAt?.toIso8601String() case final value?)
        'paid_at': value,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      if (instance.codePromoId case final value?) 'code_promo_id': value,
      'total_paid': instance.totalPaid,
      if (instance.details case final value?) 'details': value,
      'invoice_id': instance.invoiceId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      if (instance.deletedAt?.toIso8601String() case final value?)
        'deleted_at': value,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.processing: 'processing',
  PaymentStatus.failed: 'failed',
  PaymentStatus.successful: 'successful',
  PaymentStatus.canceled: 'canceled',
};
