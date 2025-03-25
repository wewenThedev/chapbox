import 'package:chapbox/models/media.dart';
import 'package:chapbox/models/product.dart';
import 'package:chapbox/models/shopProduct.dart';
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

  //final List<String> images;
  List<Media>? images;
  List<Product>? products;
  @JsonKey(ignore: true)
  List<ShopProduct>? shopProducts;

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
    //
    this.images,
    this.products,
    this.shopProducts,
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

    if (json['address'] != null) {
      shop.address = Address.fromJson(json['address']);
    }

//liste
    if (json['media'] != null) {
      final List<dynamic> imagesList = json['media'] as List<dynamic>;
      shop.images = imagesList
          .map((imageJson) => Media.fromJson(imageJson as Map<String, dynamic>))
          .toList();
    }

//liste
    if (json['products'] != null) {
      final List<dynamic> productsList = json['products'] as List<dynamic>;
      shop.products = productsList
          .map((productJson) =>
              Product.fromJson(productJson as Map<String, dynamic>))
          .toList();
    }
/*
    if (json['shop_manager'] != null) {
      shop.shopManager = User.fromJson(json['shop_manager']);
    }*/

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

  String get name {
    return '${supermarket?.name}.' '.${city}';
  }

  // Vérifie si la boutique est active
  bool get isActive => deletedAt == null;

  /////proposé par ...
  ///
  // Méthode pour récupérer le prix d'un produit spécifique
  double getProductPrice(int productId) {
    if (shopProducts == null) {
      throw Exception('Shop products not loaded');
    }

    final product = shopProducts!.firstWhere(
      (sp) => sp.productId == productId,
      orElse: () =>
          throw Exception('Product $productId not found in this shop'),
    );

    return product.price;
  }

  // Optionnel : Récupérer tous les prix sous forme de Map
  Map<int, double> getAllProductPrices() {
    return {for (var sp in shopProducts ?? []) sp.productId: sp.price};
  }

  ////
  ///
  /*Utilisation :

final shop = Shop(...); // Récupéré depuis votre service

try {
  // Pour un produit spécifique
  final price = shop.getProductPrice(123);
  print('Prix: ${price.toStringAsFixed(2)} XOF');
} catch (e) {
  print(e.toString());
}

// Pour tous les prix
final priceMap = shop.getAllProductPrices();
priceMap.forEach((productId, price) {
  print('Produit $productId : $price XOF');
});

*/
}
