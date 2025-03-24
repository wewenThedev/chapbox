import 'package:chapbox/models/cart.dart';
import 'package:chapbox/models/profile.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:chapbox/models/user.dart';
import 'package:chapbox/models/media.dart';

part 'user.g.dart';
//part 'generated/user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'firstname')
  final String firstname;

  @JsonKey(name: 'lastname')
  final String lastname;

  @JsonKey(name: 'username')
  final String username;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(
      name: 'password', ignore: true) // Ne jamais sérialiser le mot de passe
  final String? password;

  // Relations
  @JsonKey(name: 'profile_id')
  final int profileId;

  @JsonKey(name: 'picture_id', includeIfNull: false)
  final int? pictureId;

  @JsonKey(ignore: true)
  Profile? profile;

  @JsonKey(ignore: true)
  Media? picture;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  @JsonKey(name: 'cart', includeIfNull: false)
  Cart cart;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    this.phone,
    this.email,
    this.password,
    required this.profileId,
    this.pictureId,
    this.profile,
    this.picture,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.cart,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final user = _$UserFromJson(json);

    // Hydrate les relations si présentes dans le JSON
    if (json['profile'] != null) {
      user.profile = Profile.fromJson(json['profile']);
    }

    if (json['picture'] != null) {
      user.picture = Media.fromJson(json['picture']);
    }

    return user;
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  // Méthode helper pour le nom complet
  String get fullName => '$firstname $lastname';
}
