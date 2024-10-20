import 'package:json_annotation/json_annotation.dart';

part 'shop_media.g.dart';

@JsonSerializable()
class ShopMedia {
  int? shopId; // Foreign key
  int? mediaId; // Foreign key

  ShopMedia({this.shopId, this.mediaId});

  factory ShopMedia.fromJson(Map<String, dynamic> json) => _$ShopMediaFromJson(json);
  Map<String, dynamic> toJson() => _$ShopMediaToJson(this);
}
