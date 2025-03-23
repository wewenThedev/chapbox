import 'package:json_annotation/json_annotation.dart';

import 'package:chapbox/models/shop.dart';
import 'package:chapbox/models/media.dart';

//part 'generated/shop_media.g.dart';
//part 'shop_media.g.dart';
part 'shopMedia.g.dart';

@JsonSerializable(explicitToJson: true)
class ShopMedia {
  @JsonKey(name: 'shop_id')
  final int shopId;

  @JsonKey(name: 'media_id')
  final int mediaId;

  // Relations
  @JsonKey(ignore: true)
  Shop? shop;

  @JsonKey(ignore: true)
  Media? media;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  ShopMedia({
    required this.shopId,
    required this.mediaId,
    this.shop,
    this.media,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ShopMedia.fromJson(Map<String, dynamic> json) {
    final sm = _$ShopMediaFromJson(json);

    // Hydrate les relations si présentes dans le JSON
    if (json['shop'] != null) {
      sm.shop = Shop.fromJson(json['shop']);
    }

    if (json['media'] != null) {
      sm.media = Media.fromJson(json['media']);
    }

    return sm;
  }

  Map<String, dynamic> toJson() => _$ShopMediaToJson(this);

  // Helper pour vérifier si l'association est active
  bool get isActive => deletedAt == null;

  // Helper pour accéder directement à l'URL du média
  String? get mediaUrl => media?.url;
}
