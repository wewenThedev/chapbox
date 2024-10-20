import 'package:json_annotation/json_annotation.dart';

part 'generated/cart.g.dart';

@JsonSerializable()
class Cart {
  int? id;
  int? userId; // Foreign key Users
  String? deviceId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt; // Soft delete

  Cart({this.id, this.userId, this.deviceId, this.createdAt, this.updatedAt, this.deletedAt});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}