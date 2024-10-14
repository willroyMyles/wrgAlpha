import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wrg2/backend/models/model.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

class CommentModel extends Model {
  String content;
  @override
  String id;
  bool isOffer;
  String postId;
  @override
  DateTime? createdAt;
  String userId;
  String userImageUrl;
  String username;

  CommentModel({
    this.content = '',
    this.id = '',
    this.isOffer = false,
    this.postId = '',
    this.createdAt,
    this.userId = '',
    this.userImageUrl = '',
    this.username = '',
  });

  factory CommentModel.empty() => CommentModel();

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      // 'id': id,
      'isOffer': isOffer,
      'postId': postId,
      'createdAt': DateTime.now().toString(),
      'userId': userId,
      'userImageUrl': userImageUrl,
      'username': username,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      content: map['content'] ?? '',
      id: map['id'] ?? '',
      isOffer: map['isOffer'] ?? false,
      postId: map['postId'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      userId: map['userId'] ?? '',
      userImageUrl: map['userImageUrl'] ?? '',
      username: map['username'] ?? '',
    );
  }

  CommentModel operator <<(dynamic other) {
    return CommentModel.fromMap(other);
  }

  // final api = Get.find<APIService>();

  bool canSendMessage(PostModel post) {
    return isPostOwner(post) && !isOwner();
  }

  bool canAcceptOffer(PostModel post) {
    return isPostOwner(post) && !isOwner() && isOffer;
  }

  bool isOwner() {
    // return api.userInfo.value.id == userId;
    return false;
  }

  bool isPostOwner(PostModel post) {
    // return post.userInfoId == api.userInfo.value.id;
    return false;
  }

  @override
  Widget tile() {
    return Container(
      margin: EdgeInsets.only(bottom: Constants.cardVerticalMargin),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            margin: EdgeInsets.only(right: Constants.cardMargin),
            // padding: Constants.ePadding,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(10 * 5),
            //     bottomLeft: Radius.circular(10 * 5),
            //   ),
            //   color: toc.cardColor,
            // ),
            child: CircleAvatar(
              radius: 20,
              foregroundImage: Image.network(userImageUrl).image,
            )),
        Expanded(
          child: Container(
            padding: Constants.ePadding,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: toc.cardColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username),
                Text(createdAt.toString()),
                Text(content),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (userId == FirebaseAuth.instance.currentUser?.email)
                      Container(
                          child: InkWell(
                              onTap: () {
                                print(content);
                              },
                              child: Text(
                                "Options",
                                style: TextStyle(color: toc.primaryColor),
                              )))
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
