import 'package:json_annotation/json_annotation.dart';

part 'generated/paymentMethod.g.dart';

@JsonSerializable()
class PaymentMethod {
  int? id;
  String? name;
  String? description;
  int? logoId; // Foreign key
  String? termsConditions;
  double? fees; // Frais

  PaymentMethod({this.id, this.name, this.description, this.logoId, this.termsConditions, this.fees});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}
