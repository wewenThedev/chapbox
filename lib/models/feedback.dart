import 'package:json_annotation/json_annotation.dart';

part 'generated/feedback.g.dart';

@JsonSerializable()
class Feedback {
  int? id;
  int? score; // Note
  String? comment; // Commentaire
  int? orderId; // Foreign key

  Feedback({this.id, this.score, this.comment, this.orderId});

  factory Feedback.fromJson(Map<String, dynamic> json) => _$FeedbackFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
