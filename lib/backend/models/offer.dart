// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:wrg2/backend/models/conversation.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/models/userinfo.dart';

class OfferModel {
  String id;
  bool accepted = false;
  bool completed = false;
  String message;
  PostModel? post;
  String postId;
  ConversationModel? conversation;
  UserInfoModel? sender;
  UserInfoModel? reciever;
  String senderId;
  String recieverId;
  OfferModel({
    this.id = '',
    this.accepted = false,
    this.completed = false,
    this.message = '',
    this.post,
    this.postId = '',
    this.conversation,
    this.sender,
    this.reciever,
    this.senderId = '',
    this.recieverId = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'accepted': accepted,
      'completed': completed,
      'message': message,
      'post': post?.toMap(),
      'postId': postId,
      'conversation': conversation?.toMap(),
      'sender': sender?.toMap(),
      'reciever': reciever?.toMap(),
      'senderId': senderId,
      'recieverId': recieverId,
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map) {
    return OfferModel(
      id: (map['id'] ?? '') as String,
      accepted: (map['accepted'] ?? false) as bool,
      completed: (map['completed'] ?? false) as bool,
      message: (map['message'] ?? '') as String,
      post: map['post'] != null
          ? PostModel.fromMap(map['post'] as Map<String, dynamic>)
          : null,
      postId: (map['postId'] ?? '') as String,
      conversation: map['conversation'] != null
          ? ConversationModel.fromMap(
              map['conversation'] as Map<String, dynamic>)
          : null,
      sender: map['sender'] != null
          ? UserInfoModel.fromMap(map['sender'] as Map<String, dynamic>)
          : null,
      reciever: map['reciever'] != null
          ? UserInfoModel.fromMap(map['reciever'] as Map<String, dynamic>)
          : null,
      senderId: (map['senderId'] ?? '') as String,
      recieverId: (map['recieverId'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferModel.fromJson(String source) =>
      OfferModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OfferModel(id: $id, accepted: $accepted, completed: $completed, message: $message, post: $post, postId: $postId, conversation: $conversation, sender: $sender, reciever: $reciever, senderId: $senderId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OfferModel &&
        other.id == id &&
        other.accepted == accepted &&
        other.completed == completed &&
        other.message == message &&
        other.post == post &&
        other.postId == postId &&
        other.conversation == conversation &&
        other.sender == sender &&
        other.reciever == reciever &&
        other.senderId == senderId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        accepted.hashCode ^
        completed.hashCode ^
        message.hashCode ^
        post.hashCode ^
        postId.hashCode ^
        conversation.hashCode ^
        sender.hashCode ^
        reciever.hashCode ^
        senderId.hashCode;
  }

  factory OfferModel.empty() => OfferModel();
}
