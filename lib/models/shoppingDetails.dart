import 'package:json_annotation/json_annotation.dart';

import 'package:chapbox/models/cart.dart';
import 'package:chapbox/models/order.dart';
import 'package:chapbox/models/product.dart';
import 'package:chapbox/models/shop.dart';

//part 'shopping_details.g.dart';
part 'shoppingDetails.g.dart';
//part 'generated/shopping_details.g.dart';

@JsonSerializable(explicitToJson: true)
class ShoppingDetails {
  @JsonKey(name: 'id')
  final int id;

  // Relations
  @JsonKey(name: 'cart_id')
  final int cartId;

  @JsonKey(name: 'order_id')
  final int orderId;

  @JsonKey(name: 'shop_id')
  final int shopId;

  @JsonKey(name: 'product_id')
  final int productId;

  // Données transactionnelles
  @JsonKey(name: 'added_at')
  final DateTime addedAt;

  @JsonKey(name: 'quantity')
  final int quantity;

  @JsonKey(name: 'cost')
  final double cost;

  // Objets liés
  @JsonKey(ignore: true)
  Cart? cart;

  @JsonKey(ignore: true)
  Order? order;

  @JsonKey(ignore: true)
  Shop? shop;

  @JsonKey(ignore: true)
  Product? product;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  ShoppingDetails({
    required this.id,
    required this.cartId,
    required this.orderId,
    required this.shopId,
    required this.productId,
    required this.addedAt,
    required this.quantity,
    required this.cost,
    this.cart,
    this.order,
    this.shop,
    this.product,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ShoppingDetails.fromJson(Map<String, dynamic> json) {
    final detail = _$ShoppingDetailsFromJson(json);

    // Hydrate les relations si présentes
    if (json['cart'] != null) detail.cart = Cart.fromJson(json['cart']);
    if (json['order'] != null) detail.order = Order.fromJson(json['order']);
    if (json['shop'] != null) detail.shop = Shop.fromJson(json['shop']);
    if (json['product'] != null)
      detail.product = Product.fromJson(json['product']);

    return detail;
  }

  Map<String, dynamic> toJson() => _$ShoppingDetailsToJson(this);

  // Calcul du total pour cette ligne
  double get total => cost * quantity;

  // Vérifie si l'article est toujours disponible
  /*bool get isAvailable {
    return product?.stock != null &&
        product!.stock! >= quantity &&
        (deletedAt == null);
  }*/

  // Méthode pour mettre à jour la quantité
  ShoppingDetails copyWithQuantity(int newQuantity) {
    return ShoppingDetails(
      id: id,
      cartId: cartId,
      orderId: orderId,
      shopId: shopId,
      productId: productId,
      addedAt: addedAt,
      quantity: newQuantity,
      cost: cost,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      deletedAt: deletedAt,
      cart: cart,
      shop: shop,
      product: product,
    );
  }
}
