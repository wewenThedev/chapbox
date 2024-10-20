import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? firstname;
  String? lastname;
  String? username;
  String? phone;
  String? email;
  String? password;
  int? profileId; // Foreign key
  int? pictureId; // Foreign key
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt; // Soft delete

  User({this.id, this.firstname, this.lastname, this.username, this.phone, this.email, this.password, this.profileId, this.pictureId, this.createdAt, this.updatedAt, this.deletedAt});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
