import 'package:json_annotation/json_annotation.dart';

part 'generated/category.g.dart';

@JsonSerializable()
class Category {
  int? id;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt; // Soft delete

  Category({this.id, this.name, this.description, this.createdAt, this.updatedAt, this.deletedAt});

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
