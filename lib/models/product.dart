import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int? id;
  String? name;
  int? brandId; // Foreign key
  String? description;
  double? weight; // Unité en grammes
  int? categoryId; // Foreign key
  String? containerType; // Peut être nul
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt; // Soft delete

  Product({this.id, this.name, this.brandId, this.description, this.weight, this.categoryId, this.containerType, this.createdAt, this.updatedAt, this.deletedAt});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}