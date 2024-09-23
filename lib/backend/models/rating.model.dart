import 'dart:convert';

class RatingModel {
  final double score; // Rating score, e.g., between 1.0 and 5.0
  final String user; // The user who provided the rating
  final String? comment; // Optional comment
  final DateTime timestamp; // Time when the rating was given
  final String? itemId; // ID of the rated item (optional, e.g., product ID)
  RatingModel({
    this.score = 0.0,
    this.user = '',
    this.comment,
    required this.timestamp,
    this.itemId,
  });

  Map<String, dynamic> toMap() {
    return {
      'score': score,
      'user': user,
      'comment': comment,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'itemId': itemId,
    };
  }

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      score: map['score']?.toDouble() ?? 0.0,
      user: map['user'] ?? '',
      comment: map['comment'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      itemId: map['itemId'],
    );
  }

  factory RatingModel.fromJson(String source) =>
      RatingModel.fromMap(json.decode(source));
}
