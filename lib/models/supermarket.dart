import 'package:json_annotation/json_annotation.dart';

import 'package:chapbox/models/user.dart';
import 'package:chapbox/models/media.dart';
import 'package:chapbox/models/shop.dart';
import 'package:chapbox/models/address.dart';

//part 'generated/supermarket.g.dart';
part 'supermarket.g.dart';

@JsonSerializable(explicitToJson: true)
class Supermarket {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;

  @JsonKey(name: 'denomination', includeIfNull: false)
  final String? denomination;

  @JsonKey(name: 'rccm', includeIfNull: false)
  final String? rccm;

  @JsonKey(name: 'ifu', includeIfNull: false)
  final String? ifu;

  @JsonKey(name: 'website', includeIfNull: false)
  final String? website;

  // Relations

  //@JsonKey(ignore: true)
  @JsonKey(name: 'address_id')
  final int addressId;

  @JsonKey(name: 'logo_id', includeIfNull: false)
  final int? logoId;

  @JsonKey(ignore: true)
  @JsonKey(name: 'market_manager_id')
  final int? marketManagerId;

  @JsonKey(ignore: true)
  Address? address;

  @JsonKey(ignore: true)
  Media? logo;

  @JsonKey(ignore: true)
  User? marketManager;

  // Timestamps

  @JsonKey(ignore: true)
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(ignore: true)
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(ignore: true)
  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  @JsonKey(ignore: true)
  List<Shop>? shops;

  Supermarket({
    required this.id,
    required this.name,
    this.description,
    this.denomination,
    this.rccm,
    this.ifu,
    this.website,
    required this.addressId,
    this.logoId,
    this.marketManagerId,
    this.address,
    //required this.logo,
    this.logo,
    this.marketManager,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.shops,
  });

  factory Supermarket.fromJson(Map<String, dynamic> json) {
    final supermarket = _$SupermarketFromJson(json);

    // Hydrate les relations si présentes dans le JSON
    if (json['address'] != null) {
      supermarket.address = Address.fromJson(json['address']);
    }

    if (json['logo'] != null) {
      supermarket.logo = Media.fromJson(json['logo']);
    }

    if (json['market_manager'] != null) {
      supermarket.marketManager = User.fromJson(json['market_manager']);
    }

    return supermarket;
  }

  Map<String, dynamic> toJson() => _$SupermarketToJson(this);

  // Helper pour les informations légales formatées
  String get legalInfo {
    final infos = [rccm, ifu].where((i) => i != null).join(' / ');
    return infos.isNotEmpty ? infos : 'Aucune information légale';
  }

  // Vérifie si le supermarché est complètement enregistré
  bool get isVerified => rccm != null && ifu != null;
}
