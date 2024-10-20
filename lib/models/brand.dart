import 'package:json_annotation/json_annotation.dart';

part 'generated/brand.g.dart';

@JsonSerializable()
class Brand {
  int? id;
  String? name;
  String? infos;
  String? website;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt; // Soft delete

  Brand({this.id, this.name, this.infos, this.website, this.createdAt, this.updatedAt, this.deletedAt});

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
  Map<String, dynamic> toJson() => _$BrandToJson(this);
}
