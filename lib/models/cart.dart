import 'package:json_annotation/json_annotation.dart';
import 'package:chapbox/models/user.dart';

//part 'generated/cart.g.dart';
part 'cart.g.dart';

@JsonSerializable(explicitToJson: true)
class Cart {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'user_id', includeIfNull: false)
  final int? userId;

  @JsonKey(name: 'device_id', includeIfNull: false)
  final String? deviceId;

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

  Cart({
    required this.id,
    this.userId,
    this.deviceId,
    this.user,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final cart = _$CartFromJson(json);

    // Hydrate la relation utilisateur si présente
    if (json['user'] != null) {
      cart.user = User.fromJson(json['user']);
    }

    return cart;
  }

  Map<String, dynamic> toJson() => _$CartToJson(this);

  // Helper pour identifier le type de panier
  String get cartType {
    if (userId != null) return 'User Cart';
    if (deviceId != null) return 'Guest Cart';
    return 'Anonymous Cart';
  }

  // Vérifie si le panier est actif
  bool get isActive => deletedAt == null;

  // Méthode de copie pour les mises à jour
  Cart copyWith({
    int? userId,
    String? deviceId,
    DateTime? deletedAt,
  }) {
    return Cart(
      id: id,
      userId: userId ?? this.userId,
      deviceId: deviceId ?? this.deviceId,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
