import 'package:json_annotation/json_annotation.dart';

part 'promo.g.dart';

@JsonSerializable()
class Promo {
  int? id;
  String? code;
  String? description;
  String? type; // Type de promotion
  int? supermarketId; // Foreign key
  double? discount; // Montant de la réduction

  Promo({this.id, this.code, this.description, this.type, this.supermarketId, this.discount});

  factory Promo.fromJson(Map<String, dynamic> json) => _$PromoFromJson(json);
  Map<String, dynamic> toJson() => _$PromoToJson(this);
}
