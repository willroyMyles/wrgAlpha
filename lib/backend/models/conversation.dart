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
  int senderMessageCount;
  int recieverMessageCount;
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
    this.senderMessageCount = 0,
    this.recieverMessageCount = 0,
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
    return {
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
      'senderMessageCount': senderMessageCount,
      'recieverMessageCount': recieverMessageCount,
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      messages: List<MessagesModel>.from(
          map['messages']?.map((x) => MessagesModel.fromMap(x)) ?? const []),
      locked: map['locked'] ?? false,
      newMessage: map['newMessage'] ?? '',
      id: map['id'] ?? '',
      offerId: map['offerId'] ?? '',
      recieverId: map['recieverId'] ?? '',
      senderId: map['senderId'] ?? '',
      postId: map['postId'] ?? '',
      postTitle: map['postTitle'] ?? '',
      lastMessage: map['lastMessage'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastMessage'])
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      senderMessageCount: map['senderMessageCount']?.toInt() ?? 0,
      recieverMessageCount: map['recieverMessageCount']?.toInt() ?? 0,
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
