import 'package:json_annotation/json_annotation.dart';

part 'shop_product.g.dart';

@JsonSerializable()
class ShopProduct {
  int? shopId; // Foreign key
  int? productId; // Foreign key

  ShopProduct({this.shopId, this.productId});

  factory ShopProduct.fromJson(Map<String, dynamic> json) => _$ShopProductFromJson(json);
  Map<String, dynamic> toJson() => _$ShopProductToJson(this);
}
