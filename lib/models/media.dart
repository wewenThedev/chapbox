import 'package:json_annotation/json_annotation.dart';

//part 'generated/media.g.dart';
part 'media.g.dart';

@JsonSerializable(explicitToJson: true)
class Media {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'url')
  final String url;

  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  Media({
    required this.id,
    required this.name,
    required this.url,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);
  Map<String, dynamic> toJson() => _$MediaToJson(this);
}
