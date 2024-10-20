import 'package:json_annotation/json_annotation.dart';

part 'generated/profile.g.dart';

@JsonSerializable()
class Profile {
  int? id;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt; // Soft delete

  Profile({this.id, this.name, this.description, this.createdAt, this.updatedAt, this.deletedAt});

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
