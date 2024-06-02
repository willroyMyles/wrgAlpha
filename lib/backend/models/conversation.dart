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
  String offerId;
  String recieverId;
  String senderId;
  String postId;
  String postTitle;
  DateTime? lastMessage;
  DateTime? createdAt;
  ConversationModel({
    this.messages = const [],
    this.locked = false,
    this.newMessage = '',
    this.id = '',
    this.offerId = '',
    this.recieverId = '',
    this.senderId = '',
    this.postId = '',
    this.postTitle = '',
    this.lastMessage,
    this.createdAt,
  }) {
    if (id.isEmpty) {
      id = nanoid(length: 7);
    }
    createdAt ??= DateTime.now();
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
      'offerId': offerId,
      'recieverId': recieverId,
      'senderId': senderId,
      'postId': postId,
      'postTitle': postTitle,
      'lastMessage': lastMessage?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
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
      offerId: (map['offerId'] ?? '') as String,
      recieverId: (map['recieverId'] ?? '') as String,
      senderId: (map['senderId'] ?? '') as String,
      postId: (map['postId'] ?? '') as String,
      postTitle: (map['postTitle'] ?? '') as String,
      lastMessage: map['lastMessage'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (map['lastMessage'] ?? 0) as int)
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['createdAt'] ?? 0) as int)
          : null,
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
        margin: Constants.ePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Opacity(
                    opacity: .7,
                    child: Text(
                      "your messages with ",
                      style: TS.hint1,
                    )),
                Txt(getOthersName() ?? "no name").h2,
                Opacity(
                    opacity: .7,
                    child: Text(
                      " about: ",
                      style: TS.hint1,
                    )),
                Txt(postTitle.capitalize!).h2,
              ],
            )
          ],
        ),
      ),
    );
  }
}
