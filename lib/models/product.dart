import 'package:chapbox/models/media.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:chapbox/models/brand.dart';
import 'package:chapbox/models/category.dart';

//part 'generated/product.g.dart';
part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  // Relations
  @JsonKey(name: 'brand_id')
  final int brandId;

  @JsonKey(name: 'category_id')
  final int categoryId;

  @JsonKey(ignore: true)
  Brand? brand;

  @JsonKey(ignore: true)
  Category? category;

  // Caractéristiques produit
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;

  @JsonKey(name: 'weight') // en grammes
  final double weight;

  @JsonKey(name: 'container_type', includeIfNull: false)
  final String? containerType;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  @JsonKey(ignore: true)
  List<Media>? images;

  Product({
    required this.id,
    required this.name,
    required this.brandId,
    required this.categoryId,
    this.brand,
    this.category,
    this.description,
    required this.weight,
    this.containerType,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    //
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final product = _$ProductFromJson(json);

    // Hydrate les relations si présentes dans le JSON
    if (json['brand'] != null) {
      product.brand = Brand.fromJson(json['brand']);
    }

    if (json['category'] != null) {
      product.category = Category.fromJson(json['category']);
    }

    if (json['media'] != null) {
      //product.images = Category.fromJson(json['category']);

      final List<dynamic> imagesList = json['media'] as List<dynamic>;
      product.images = imagesList
          .map((mediaJson) => Media.fromJson(mediaJson as Map<String, dynamic>))
          .toList();
    }

    return product;
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  // Helper pour le poids formaté
  String get formattedWeight {
    if (weight >= 1000) {
      return '${(weight / 1000).toStringAsFixed(1)} kg';
    }
    return '${weight.toStringAsFixed(0)} g';
  }

  // Helper pour le type de conteneur
  String get containerTypeFormatted {
    return containerType?.toUpperCase() ?? 'N/A';
  }
}
