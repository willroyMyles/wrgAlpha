// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class MessagesModel {
  String sender;
  String content;
  String id;
  DateTime? createdAt;
  MessagesModel({
    this.sender = '',
    this.content = '',
    this.id = '',
    this.createdAt,
  }) {
    createdAt ??= DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'content': content,
      'id': id,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory MessagesModel.fromMap(Map<String, dynamic> map) {
    return MessagesModel(
      sender: (map['sender'] ?? '') as String,
      content: (map['content'] ?? '') as String,
      id: (map['id'] ?? '') as String,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['createdAt'] ?? 0) as int)
          : null,
    );
  }

  factory MessagesModel.empty() => MessagesModel();

  bool amISender() {
    var state = GF<ProfileState>();
    if (state.userModel == null) return false;
    return state.userModel!.value.email == sender;
  }

  static Widget multiTile(List<MessagesModel> items) {
    var imsender = items.first.amISender();
    return Container(
      alignment: imsender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              imsender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ...items.map((e) {
              var r = 5.0;
              var nr = 0.0;
              var tl = Radius.circular(r);
              var tr = Radius.circular(r);
              var bl = Radius.circular(r);
              var br = Radius.circular(r);

              if (imsender) {
                if (e != items.last && e != items.first) {
                  br = Radius.circular(nr);
                  tr = Radius.circular(nr);
                }

                if (e == items.first) {
                  br = Radius.circular(nr);
                  bl = Radius.circular(nr);
                  tl = Radius.circular(r);
                  tr = Radius.circular(r);
                }

                if (e == items.last) {
                  tr = Radius.circular(nr);
                  tl = Radius.circular(r);
                  bl = Radius.circular(r);
                  br = Radius.circular(r);
                }
              }

              if (!imsender && e != items.last && e != items.first) {
                bl = Radius.circular(nr);
                tl = Radius.circular(nr);
              }

              return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Constants.cardMargin,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: tl,
                        topRight: tr,
                        bottomLeft: bl,
                        bottomRight: br,
                      ),
                      color: imsender
                          ? toc.scaffoldBackgroundColor.darker
                          : toc.scaffoldBackgroundColor.lighterF(10)),
                  // margin:
                  //     const EdgeInsets.symmetric(vertical: .5, horizontal: 3),
                  child: Txt(
                    e.content,
                  ).h4);
            }),
          ],
        ),
      ),
    );
  }

  Widget tile([Key? key]) {
    return Container(
      alignment: amISender() ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        key: key,
        constraints: BoxConstraints(maxWidth: Get.width * .7),
        margin: EdgeInsets.symmetric(
          horizontal: Constants.cardMargin,
          vertical: Constants.cardVerticalMargin / 3,
        ),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: amISender()
                    ? toc.scaffoldBackgroundColor.darkerF(10)
                    : toc.scaffoldBackgroundColor.lighterF(10)),
            child: Text(
              content.capitalizeFirst!,
              maxLines: 20,
              style: TS.h4,
            )),
      ),
    );
  }
}
