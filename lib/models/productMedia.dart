import 'package:json_annotation/json_annotation.dart';
import 'package:chapbox/models/product.dart';
import 'package:chapbox/models/media.dart';

//part 'generated/product_media.g.dart';

part 'productMedia.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductMedia {
  @JsonKey(name: 'product_id')
  final int productId;

  @JsonKey(name: 'media_id')
  final int mediaId;

  // Relations
  @JsonKey(ignore: true)
  Product? product;

  @JsonKey(ignore: true)
  Media? media;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  ProductMedia({
    required this.productId,
    required this.mediaId,
    this.product,
    this.media,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ProductMedia.fromJson(Map<String, dynamic> json) {
    final pm = _$ProductMediaFromJson(json);

    // Hydrate les relations si présentes dans le JSON
    if (json['product'] != null) {
      pm.product = Product.fromJson(json['product']);
    }

    if (json['media'] != null) {
      pm.media = Media.fromJson(json['media']);
    }

    return pm;
  }

  Map<String, dynamic> toJson() => _$ProductMediaToJson(this);

  // Helper pour vérifier si la relation est active
  bool get isActive => deletedAt == null;
}
