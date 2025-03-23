import 'package:json_annotation/json_annotation.dart';

import 'package:chapbox/models/order.dart';

//part 'generated/feedback.g.dart';
part 'feedback.g.dart';

@JsonSerializable(explicitToJson: true)
class Feedback {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'score')
  final double score; // Décimal(3,2) entre 0.00 et 5.00

  @JsonKey(name: 'comment', includeIfNull: false)
  final String? comment;

  @JsonKey(name: 'order_id')
  final int orderId;

  // Relations
  @JsonKey(ignore: true)
  Order? order;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'deleted_at', includeIfNull: false)
  final DateTime? deletedAt;

  Feedback({
    required this.id,
    required this.score,
    this.comment,
    required this.orderId,
    this.order,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) {
    final feedback = _$FeedbackFromJson(json);

    // Hydrate la commande associée si présente
    if (json['order'] != null) {
      feedback.order = Order.fromJson(json['order']);
    }

    return feedback;
  }

  Map<String, dynamic> toJson() => _$FeedbackToJson(this);

  // Helper pour la note formatée (ex: ⭐⭐⭐⭐☆)
  String get formattedRating {
    final fullStars = score.floor();
    final halfStar = (score - fullStars) >= 0.5 ? 1 : 0;
    return '${'⭐' * fullStars}${halfStar > 0 ? '½' : ''}'.padRight(5, '☆');
  }

  // Vérifie si la note est valide
  bool get isValidScore => score >= 0.0 && score <= 5.0;

  // Vérifie si le feedback est actif
  bool get isActive => deletedAt == null;

  // Convertit la note en pourcentage
  double get percentage => (score / 5.0) * 100;

  // Méthode pour créer un feedback mise à jour
  Feedback copyWith({
    double? newScore,
    String? newComment,
  }) {
    return Feedback(
      id: id,
      score: newScore ?? score,
      comment: newComment ?? comment,
      orderId: orderId,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
