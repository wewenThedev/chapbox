import 'package:json_annotation/json_annotation.dart';

part 'generated/shopping_details.g.dart';

@JsonSerializable()
class ShoppingDetails {
  int? id;
  int? cartId; // Foreign key
  int? shopId; // Foreign key
  int? productId; // Foreign key
  DateTime? addedAt;
  int? quantity;
  double? cost; // Coût

  ShoppingDetails({this.id, this.cartId, this.shopId, this.productId, this.addedAt, this.quantity, this.cost});

  factory ShoppingDetails.fromJson(Map<String, dynamic> json) => _$ShoppingDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$ShoppingDetailsToJson(this);
}
