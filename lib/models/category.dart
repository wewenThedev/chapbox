import 'package:json_annotation/json_annotation.dart';

//part 'generated/category.g.dart';
part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  final int? productsCount;

  Category({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.productsCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  // Helper pour afficher une description tronquée
  String get shortDescription {
    if (description == null) return '';
    return description!.length > 100
        ? '${description!.substring(0, 100)}...'
        : description!;
  }
}
