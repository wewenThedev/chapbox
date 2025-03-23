import 'package:json_annotation/json_annotation.dart';

//part 'generated/notification.g.dart';
part 'notification.g.dart';

@JsonSerializable(explicitToJson: true)
class Notification {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  Notification({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  // Méthode helper pour afficher le temps écoulé (ex: "Il y a 5 minutes")
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    // Implémentez la logique de formatage ou utilisez un package comme timeago
    return '${difference.inMinutes} minutes ago';
  }
}
