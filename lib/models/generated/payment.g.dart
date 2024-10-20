// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      orderId: (json['orderId'] as num?)?.toInt(),
      methodId: (json['methodId'] as num?)?.toInt(),
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
      status: json['status'] as String?,
      codePromoId: (json['codePromoId'] as num?)?.toInt(),
      totalPaid: (json['totalPaid'] as num?)?.toDouble(),
      details: json['details'] as String?,
      invoiceId: (json['invoiceId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'methodId': instance.methodId,
      'paidAt': instance.paidAt?.toIso8601String(),
      'status': instance.status,
      'codePromoId': instance.codePromoId,
      'totalPaid': instance.totalPaid,
      'details': instance.details,
      'invoiceId': instance.invoiceId,
    };
