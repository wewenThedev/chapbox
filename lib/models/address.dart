import 'package:json_annotation/json_annotation.dart';

part 'generated/address.g.dart';

@JsonSerializable()
class Address {
  int? id;
  String? name;
  String? fullAddress;
  double? latitude;
  double? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt; // Soft delete

  Address({this.id, this.name, this.fullAddress, this.latitude, this.longitude, this.createdAt, this.updatedAt, this.deletedAt});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
