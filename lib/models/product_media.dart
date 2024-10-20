import 'package:json_annotation/json_annotation.dart';

part 'generated/product_media.g.dart';

@JsonSerializable()
class ProductMedia {
  int? productId; // Foreign key
  int? mediaId; // Foreign key

  ProductMedia({this.productId, this.mediaId});

  factory ProductMedia.fromJson(Map<String, dynamic> json) => _$ProductMediaFromJson(json);
  Map<String, dynamic> toJson() => _$ProductMediaToJson(this);
}
