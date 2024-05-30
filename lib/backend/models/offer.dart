// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OfferModel {
  String id;
  bool accepted = false;
  bool completed = false;
  String message;
  String? conversationId;
  String postId;
  String postTitle;
  String senderId;
  String snederName;
  String senderPhoto;
  String recieverId;
  DateTime? createdAt;
  OfferModel({
    this.id = '',
    this.accepted = false,
    this.completed = false,
    this.message = '',
    this.conversationId,
    this.postId = '',
    this.postTitle = '',
    this.senderId = '',
    this.snederName = '',
    this.senderPhoto = '',
    this.recieverId = '',
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'accepted': accepted,
      'completed': completed,
      'message': message,
      'conversationId': conversationId,
      'postId': postId,
      'postTitle': postTitle,
      'senderId': senderId,
      'snederName': snederName,
      'senderPhoto': senderPhoto,
      'recieverId': recieverId,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map) {
    return OfferModel(
      id: (map['id'] ?? '') as String,
      accepted: (map['accepted'] ?? false) as bool,
      completed: (map['completed'] ?? false) as bool,
      message: (map['message'] ?? '') as String,
      conversationId: map['conversationId'] != null
          ? map['conversationId'] as String
          : null,
      postId: (map['postId'] ?? '') as String,
      postTitle: (map['postTitle'] ?? '') as String,
      senderId: (map['senderId'] ?? '') as String,
      snederName: (map['snederName'] ?? '') as String,
      senderPhoto: (map['senderPhoto'] ?? '') as String,
      recieverId: (map['recieverId'] ?? '') as String,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['createdAt'] ?? 0) as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferModel.fromJson(String source) =>
      OfferModel.fromMap(json.decode(source));

  factory OfferModel.empty() => OfferModel();
}
