import 'package:chapbox/models/media.dart';
import 'package:json_annotation/json_annotation.dart';

//part 'generated/paymentMethod.g.dart';
part 'paymentMethod.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentMethod {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;

  @JsonKey(name: 'logo_id', includeIfNull: false)
  final int? logoId;

  @JsonKey(name: 'terms_conditions', includeIfNull: false)
  final String? termsConditions;

  @JsonKey(name: 'fees', includeIfNull: false)
  final double? fees;

  // Relations
  @JsonKey(ignore: true)
  Media? logo;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  PaymentMethod({
    required this.id,
    required this.name,
    this.description,
    this.logoId,
    this.termsConditions,
    this.fees,
    this.logo,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    final pm = _$PaymentMethodFromJson(json);

    // Hydrate le logo si présent dans la réponse
    if (json['logo'] != null) {
      pm.logo = Media.fromJson(json['logo']);
    }

    return pm;
  }

  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);

  // Helper pour les frais formatés
  String get formattedFees {
    if (fees == null) return 'Gratuit';
    return '${fees!.toStringAsFixed(2)} XOF';
  }

  // Vérifie si la méthode a des frais
  bool get hasFees => fees != null && fees! > 0;

  // Helper pour les CGU tronquées
  String get shortTerms {
    final terms = termsConditions ?? '';
    return terms.length > 100 ? '${terms.substring(0, 100)}...' : terms;
  }

  // Vérifie si la méthode est active
  bool get isActive => deletedAt == null;
}
