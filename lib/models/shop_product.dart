import 'package:json_annotation/json_annotation.dart';

part 'generated/shop_product.g.dart';

@JsonSerializable()
class ShopProduct {
  int shopId; // Foreign key
  int productId; // Foreign key
  //List<Media> images;

  ShopProduct({required this.shopId, required this.productId});
  //ShopProduct({required this.shopId, required this.productId, required this.images});

  factory ShopProduct.fromJson(Map<String, dynamic> json) => _$ShopProductFromJson(json);
  Map<String, dynamic> toJson() => _$ShopProductToJson(this);
}
