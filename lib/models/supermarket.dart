import 'package:chapbox/models/shop.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/supermarket.g.dart';

@JsonSerializable()
class Supermarket {
  int? id;
  String? name;
  String? description;
  String? denomination;
  String? rccm;
  String? ifu;
  String? website;
  int? addressId; // Foreign key
  int? logoId; // Foreign key
  int? marketManagerId; // Foreign key
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt; // Soft delete

  final List<Shop> shops;

  Supermarket(
      {this.id,
      required this.shops,
      this.name,
      this.description,
      this.denomination,
      this.rccm,
      this.ifu,
      this.website,
      this.addressId,
      this.logoId,
      this.marketManagerId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  factory Supermarket.fromJson(Map<String, dynamic> json) =>
      _$SupermarketFromJson(json);
  Map<String, dynamic> toJson() => _$SupermarketToJson(this);
}
