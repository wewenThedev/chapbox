import 'package:chapbox/models/supermarket.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'generated/promo.g.dart';
part 'promo.g.dart';

enum PromoType { percentage, fixed, free_shipping, other }

@JsonSerializable(explicitToJson: true)
class Promo {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'code')
  final String code;

  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;

  @JsonKey(name: 'type', unknownEnumValue: PromoType.other)
  final PromoType type;

  @JsonKey(name: 'supermarket_id', includeIfNull: false)
  final int? supermarketId;

  @JsonKey(name: 'discount')
  final double discount;

  // Relations
  @JsonKey(ignore: true)
  Supermarket? supermarket;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  Promo({
    required this.id,
    required this.code,
    this.description,
    required this.type,
    this.supermarketId,
    required this.discount,
    this.supermarket,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    final promo = _$PromoFromJson(json);

    // Hydrate la relation supermarket si présente
    if (json['supermarket'] != null) {
      promo.supermarket = Supermarket.fromJson(json['supermarket']);
    }

    return promo;
  }

  Map<String, dynamic> toJson() => _$PromoToJson(this);

  // Helper pour l'affichage du discount
  String get formattedDiscount {
    switch (type) {
      case PromoType.percentage:
        return '${discount.toStringAsFixed(1)}%';
      case PromoType.fixed:
        return '${discount.toStringAsFixed(2)} XOF';
      case PromoType.free_shipping:
        return 'Livraison offerte';
      default:
        return 'Réduction spéciale';
    }
  }

  // Vérifie si la promo est globale
  bool get isGlobal => supermarketId == null;

  // Vérifie si la promo est active
  bool get isActive => deletedAt == null;

  // Valide le montant du discount selon le type
  bool get isValidDiscount {
    switch (type) {
      case PromoType.percentage:
        return discount >= 0 && discount <= 100;
      case PromoType.fixed:
        return discount >= 0;
      default:
        return true;
    }
  }
}

// Convertisseur pour le type de promo
class PromoTypeConverter extends JsonConverter<PromoType, String> {
  const PromoTypeConverter();

  @override
  PromoType fromJson(String json) {
    switch (json.toLowerCase()) {
      case 'percentage':
        return PromoType.percentage;
      case 'fixed':
        return PromoType.fixed;
      case 'free_shipping':
        return PromoType.free_shipping;
      default:
        return PromoType.other;
    }
  }

  @override
  String toJson(PromoType object) => object.toString().split('.').last;
}
