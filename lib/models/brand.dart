import 'package:json_annotation/json_annotation.dart';

import 'package:chapbox/models/brand.dart';

//part 'generated/brand.g.dart';
part 'brand.g.dart';

@JsonSerializable(explicitToJson: true)
class Brand {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'logo_id', includeIfNull: false)
  final int? logoId;

  @JsonKey(name: 'infos', includeIfNull: false)
  final String? infos;

  @JsonKey(name: 'website', includeIfNull: false)
  final String? website;

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

  Brand({
    required this.id,
    required this.name,
    this.logoId,
    this.infos,
    this.website,
    this.logo,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    final brand = _$BrandFromJson(json);

    // Hydrate le logo si présent dans la réponse
    if (json['logo'] != null) {
      brand.logo = Media.fromJson(json['logo']);
    }

    return brand;
  }

  Map<String, dynamic> toJson() => _$BrandToJson(this);

  // Helper pour l'affichage condensé des infos
  String get shortInfo {
    final info = infos?.replaceAll('\n', ' ') ?? '';
    return info.length > 50 ? '${info.substring(0, 50)}...' : info;
  }

  // Helper pour l'URL du logo
  String? get logoUrl => logo?.url;
}
