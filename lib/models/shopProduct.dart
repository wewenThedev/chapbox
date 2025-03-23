import 'package:json_annotation/json_annotation.dart';

import 'package:chapbox/models/product.dart';
import 'package:chapbox/models/shop.dart';

/*part 'generated/shop_media.g.dart';
part 'shop_product.g.dart';
*/
part 'shopProduct.g.dart';

@JsonSerializable(explicitToJson: true)
class ShopProduct {
  @JsonKey(name: 'shop_id')
  final int shopId;

  @JsonKey(name: 'product_id')
  final int productId;

  @JsonKey(name: 'price')
  final double price; // Decimal(8,2)

  @JsonKey(name: 'stock', defaultValue: 0)
  final int stock;

  // Relations
  @JsonKey(ignore: true)
  Shop? shop;

  @JsonKey(ignore: true)
  Product? product;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

//to implement
  final String? fullName;

  ShopProduct(
      {required this.shopId,
      required this.productId,
      required this.price,
      required this.stock,
      this.shop,
      this.product,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      this.fullName});

  factory ShopProduct.fromJson(Map<String, dynamic> json) {
    final sp = _$ShopProductFromJson(json);

    // Hydrate les relations si présentes dans le JSON
    if (json['shop'] != null) {
      sp.shop = Shop.fromJson(json['shop']);
    }

    if (json['product'] != null) {
      sp.product = Product.fromJson(json['product']);
    }

    return sp;
  }

  Map<String, dynamic> toJson() => _$ShopProductToJson(this);

  // Helper pour le prix formaté
  String get formattedPrice => '${price.toStringAsFixed(2)} XOF';

  // Vérifie la disponibilité en stock
  bool get isInStock => stock > 0;

  // Helper pour le statut d'activité
  bool get isActive => deletedAt == null;

  // Méthode pour mettre à jour le prix
  ShopProduct copyWith({double? newPrice, int? newStock}) {
    return ShopProduct(
      shopId: shopId,
      productId: productId,
      price: newPrice ?? price,
      stock: newStock ?? stock,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      deletedAt: deletedAt,
    );
  }
}
