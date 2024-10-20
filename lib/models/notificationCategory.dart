import 'package:json_annotation/json_annotation.dart';

part 'generated/notificationCategory.g.dart';

@JsonSerializable()
class NotificationCategory {
  int? id;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt; // Soft delete

  NotificationCategory({this.id, this.name, this.description, this.createdAt, this.updatedAt, this.deletedAt});

  factory NotificationCategory.fromJson(Map<String, dynamic> json) => _$NotificationCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationCategoryToJson(this);
}
