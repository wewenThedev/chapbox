import 'package:json_annotation/json_annotation.dart';

import 'package:chapbox/models/address.dart';
import 'package:chapbox/models/supermarket.dart';
import 'package:chapbox/models/user.dart';

part 'shop.g.dart';
//part 'generated/shop.g.dart';

@JsonSerializable(explicitToJson: true)
class Shop {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'city')
  final String city;

  @JsonKey(name: 'phone')
  final String phone;

  // Relations
  @JsonKey(name: 'address_id')
  final int addressId;

  @JsonKey(name: 'supermarket_id')
  final int supermarketId;

  @JsonKey(name: 'shop_manager_id')
  final int? shopManagerId;

  @JsonKey(ignore: true)
  Address? address;

  @JsonKey(ignore: true)
  Supermarket? supermarket;

  @JsonKey(ignore: true)
  User? shopManager;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  /*
  final List<String> images;
  final Supermarket supermarket;
  final List<Product> products;
*/

  Shop({
    required this.id,
    required this.city,
    required this.phone,
    required this.addressId,
    required this.supermarketId,
    //required this.shopManagerId,
    this.shopManagerId,
    this.address,
    this.supermarket,
    this.shopManager,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    /*
        required this.images,
    required this.supermarket,
    required this.products,

    */
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    final shop = _$ShopFromJson(json);

    // Hydrate les relations si présentes dans le JSON
    if (json['address'] != null) {
      shop.address = Address.fromJson(json['address']);
    }

    if (json['supermarket'] != null) {
      shop.supermarket = Supermarket.fromJson(json['supermarket']);
    }

    if (json['shop_manager'] != null) {
      shop.shopManager = User.fromJson(json['shop_manager']);
    }

    return shop;
  }

  Map<String, dynamic> toJson() => _$ShopToJson(this);

  // Helper pour formater le numéro de téléphone
  String get formattedPhone {
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    if (cleanPhone.length == 8) {
      return '${cleanPhone.substring(0, 2)} ${cleanPhone.substring(2, 4)} ${cleanPhone.substring(4, 6)} ${cleanPhone.substring(6)}';
    }
    return phone;
  }

  // Vérifie si la boutique est active
  bool get isActive => deletedAt == null;
}
