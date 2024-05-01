// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanoid2/nanoid2.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/messages.dart';
import 'package:wrg2/backend/models/userinfo.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.auth.dart';
import 'package:wrg2/frontend/pages/messages/detail/view.messageDetails.dart';

class ConversationModel {
  // UserInfoModel reciever;
  // UserInfoModel sender;
  List<MessagesModel> messages = [];
  bool locked = false;
  String newMessage;
  String id;
  String recieverId;
  String senderId;
  String commentId;
  String postId;
  ConversationModel({
    this.messages = const [],
    this.locked = false,
    this.newMessage = '',
    this.id = '',
    this.recieverId = '',
    this.senderId = '',
    this.commentId = '',
    this.postId = '',
  }) {
    if (id.isEmpty) {
      id = nanoid(length: 7);
    }
  }

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
    return senderId == authWorker.user!.value.email ? recieverId : senderId;
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
        (map['messages']).map<MessagesModel>(
          (x) => MessagesModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      locked: (map['locked'] ?? false) as bool,
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

  Widget tile() {
    return InkWell(
      onTap: () {
        Get.to(() => MessageDetailView(), arguments: {"conversation": this});
      },
      child: Container(
        padding: Constants.ePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Opacity(opacity: .7, child: Text("your messages with")),
            Txt(getOthersName() ?? "no name").h2,
          ],
        ),
      ),
    );
  }
}
