import 'package:json_annotation/json_annotation.dart';

part 'generated/media.g.dart';

@JsonSerializable()
class Media {
  int? id;
  String? name;
  String? url;
  String? type; // ex: image, video, gif
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt; // Soft delete

  Media({this.id, this.name, this.url, this.type, this.description, this.createdAt, this.updatedAt, this.deletedAt});

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
  Map<String, dynamic> toJson() => _$MediaToJson(this);
}
