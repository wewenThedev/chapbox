import 'package:json_annotation/json_annotation.dart';

part 'generated/payment.g.dart';

@JsonSerializable()
class Payment {
  int? orderId; // Foreign key
  int? methodId; // Foreign key
  DateTime? paidAt;
  String? status;
  int? codePromoId; // Foreign key, peut être nul
  double? totalPaid;
  String? details;
  int? invoiceId; // Foreign key

  Payment({this.orderId, this.methodId, this.paidAt, this.status, this.codePromoId, this.totalPaid, this.details, this.invoiceId});

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
