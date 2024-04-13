// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:wrg2/backend/models/comment.model.dart';
import 'package:wrg2/backend/models/messages.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/models/userinfo.dart';

class ConversationModel {
  // UserInfoModel reciever;
  // UserInfoModel sender;
  List<MessagesModel> messages = [];
  bool locked = false;
  CommentModel? comment;
  PostModel? post;
  String newMessage;
  String id;
  String recieverId;
  String senderId;
  String commentId;
  String postId;
  ConversationModel({
    this.messages = const [],
    this.locked = false,
    this.comment,
    this.post,
    this.newMessage = '',
    this.id = '',
    this.recieverId = '',
    this.senderId = '',
    this.commentId = '',
    this.postId = '',
  });

  bool hasNewMessageForMe() {
    // final APIService ser = Get.find();
    // return newMessage == ser.userInfo.value.id;
    return false;
  }

  bool amISender(MessagesModel model) {
    // final APIService ser = Get.find();
    // var isSender = model.sender == ser.userInfo.value.userId;
    // return isSender;
    return false;
  }

  getOthersId() {
    // final APIService ser = Get.find();
    // return sender.id == ser.userInfo.value.id ? reciever.id : sender.id;
    return false;
  }

  getOthersName() {
    // final APIService ser = Get.find();
    // return sender.id == ser.userInfo.value.id
    //     ? reciever.username
    //     : sender.username;
  }

  UserInfoModel? getOthersUserInfo() {
    return null;

    // final APIService ser = Get.find();
    // return sender.id == ser.userInfo.value.id ? reciever : sender;
  }

  factory ConversationModel.empty() => ConversationModel(messages: []);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messages': messages.map((x) => x.toMap()).toList(),
      'locked': locked,
      'comment': comment?.toMap(),
      'post': post?.toMap(),
      'newMessage': newMessage,
      'id': id,
      'recieverId': recieverId,
      'senderId': senderId,
      'commentId': commentId,
      'postId': postId,
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      messages: List<MessagesModel>.from(
        (map['messages'] as List<int>).map<MessagesModel>(
          (x) => MessagesModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      locked: (map['locked'] ?? false) as bool,
      comment: map['comment'] != null
          ? CommentModel.fromMap(map['comment'] as Map<String, dynamic>)
          : null,
      post: map['post'] != null
          ? PostModel.fromMap(map['post'] as Map<String, dynamic>)
          : null,
      newMessage: (map['newMessage'] ?? '') as String,
      id: (map['id'] ?? '') as String,
      recieverId: (map['recieverId'] ?? '') as String,
      senderId: (map['senderId'] ?? '') as String,
      commentId: (map['commentId'] ?? '') as String,
      postId: (map['postId'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationModel.fromJson(String source) =>
      ConversationModel.fromMap(json.decode(source));
}
