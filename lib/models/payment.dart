import 'package:json_annotation/json_annotation.dart';

import 'package:chapbox/models/order.dart';
import 'package:chapbox/models/paymentMethod.dart';
import 'package:chapbox/models/promo.dart';
import 'package:chapbox/models/invoice.dart';

part 'payment.g.dart';
//part 'generated/payment.g.dart';

enum PaymentStatus { processing, failed, successful, canceled }

@JsonSerializable(explicitToJson: true)
class Payment {
  @JsonKey(name: 'order_id')
  final int orderId;

  @JsonKey(name: 'method_id')
  final int methodId;

  @JsonKey(name: 'paid_at', includeIfNull: false)
  final DateTime? paidAt;

  @JsonKey(name: 'status', unknownEnumValue: PaymentStatus.processing)
  final PaymentStatus status;

  @JsonKey(name: 'code_promo_id', includeIfNull: false)
  final int? codePromoId;

  @JsonKey(name: 'total_paid')
  final double totalPaid;

  @JsonKey(name: 'details', includeIfNull: false)
  final String? details;

  @JsonKey(name: 'invoice_id')
  final int invoiceId;

  // Relations
  @JsonKey(ignore: true)
  Order? order;

  @JsonKey(ignore: true)
  PaymentMethod? method;

  @JsonKey(ignore: true)
  Promo? promo;

  @JsonKey(ignore: true)
  Invoice? invoice;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  Payment({
    required this.orderId,
    required this.methodId,
    this.paidAt,
    required this.status,
    this.codePromoId,
    required this.totalPaid,
    this.details,
    required this.invoiceId,
    this.order,
    this.method,
    this.promo,
    this.invoice,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    final payment = _$PaymentFromJson(json);

    // Hydrate les relations
    if (json['order'] != null) payment.order = Order.fromJson(json['order']);
    if (json['payment_method'] != null)
      payment.method = PaymentMethod.fromJson(json['payment_method']);
    if (json['code_promo'] != null)
      payment.promo = Promo.fromJson(json['code_promo']);
    if (json['invoice'] != null)
      payment.invoice = Invoice.fromJson(json['invoice']);

    return payment;
  }

  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  // Helpers
  String get formattedTotalPaid => '${totalPaid.toStringAsFixed(2)} XOF';

  bool get isSuccessful => status == PaymentStatus.successful;

  bool get hasPromo => codePromoId != null;

  Duration get processingDuration {
    if (paidAt == null || status != PaymentStatus.successful)
      return Duration.zero;
    return paidAt!.difference(createdAt!);
  }

  Payment copyWithStatus(PaymentStatus newStatus) {
    return Payment(
      orderId: orderId,
      methodId: methodId,
      status: newStatus,
      totalPaid: totalPaid,
      invoiceId: invoiceId,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      // Copier les autres champs
      paidAt: newStatus == PaymentStatus.successful ? DateTime.now() : paidAt,
      codePromoId: codePromoId,
      details: details,
    );
  }
}

// Convertisseur pour le statut de paiement
class PaymentStatusConverter extends JsonConverter<PaymentStatus, String> {
  const PaymentStatusConverter();

  @override
  PaymentStatus fromJson(String json) {
    switch (json.toLowerCase()) {
      case 'processing':
        return PaymentStatus.processing;
      case 'failed':
        return PaymentStatus.failed;
      case 'successful':
        return PaymentStatus.successful;
      case 'canceled':
        return PaymentStatus.canceled;
      default:
        return PaymentStatus.processing;
    }
  }

  @override
  String toJson(PaymentStatus object) => object.toString().split('.').last;
}
