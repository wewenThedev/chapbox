import 'package:json_annotation/json_annotation.dart';

import 'package:chapbox/models/user.dart';

//part 'generated/address.g.dart';
part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'user_id', includeIfNull: false)
  final int? userId;

  @JsonKey(name: 'fullAddress')
  final String fullAddress;

  @JsonKey(name: 'latitude')
  final double latitude;

  @JsonKey(name: 'longitude')
  final double longitude;

  // Relations
  @JsonKey(ignore: true)
  User? user;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  Address({
    required this.id,
    required this.name,
    this.userId,
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
    this.user,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    final address = _$AddressFromJson(json);

    // Hydrate la relation user si présente dans le JSON
    if (json['user'] != null) {
      address.user = User.fromJson(json['user']);
    }

    return address;
  }

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  // Helper pour les coordonnées (utile avec des packages comme google_maps_flutter)
  Map<String, double> get coordinates =>
      {'latitude': latitude, 'longitude': longitude};

  // Helper pour l'affichage formaté
  String get formattedAddress {
    final parts = [fullAddress];
    if (user != null) parts.add('(${user!.fullName})');
    return parts.join(' ');
  }
}
