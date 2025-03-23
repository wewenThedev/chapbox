import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'generated/invoice.g.dart';
part 'invoice.g.dart';

@JsonSerializable(explicitToJson: true)
class Invoice {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'url')
  final String url;

  @JsonKey(name: 'infos', includeIfNull: false)
  final String? infos;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  Invoice({
    required this.id,
    required this.url,
    this.infos,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

  // Helper pour vérifier si la facture est active
  bool get isActive => deletedAt == null;

  // Helper pour extraire le nom du fichier depuis l'URL
  String get fileName {
    try {
      return url.split('/').last;
    } catch (_) {
      return 'facture.pdf';
    }
  }

  // Convertit les infos texte en Map si c'est du JSON
  Map<String, dynamic>? get parsedInfos {
    if (infos == null) return null;
    try {
      return jsonDecode(infos!);
    } catch (_) {
      return null;
    }
  }

  // Vérifie la validité de l'URL
  bool get isValidUrl {
    try {
      Uri.parse(url);
      return true;
    } catch (_) {
      return false;
    }
  }
}
