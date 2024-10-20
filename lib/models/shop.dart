import 'package:json_annotation/json_annotation.dart';

part 'generated/shop.g.dart';

@JsonSerializable()
class Shop {
  int? id;
  String? city;
  String? phone;
  int? addressId; // Foreign key
  int? supermarketId; // Foreign key
  int? shopManagerId; // Foreign key
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt; // Soft delete

  Shop({this.id, this.city, this.phone, this.addressId, this.supermarketId, this.shopManagerId, this.createdAt, this.updatedAt, this.deletedAt});

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
  Map<String, dynamic> toJson() => _$ShopToJson(this);
}
