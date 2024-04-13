import 'dart:convert';

import 'package:wrg2/backend/models/post.model.dart';

class CommentModel {
  String content;
  String id;
  bool isOffer;
  String postId;
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
      // 'createdAt': createdAt,
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

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommentModel(content: $content, id: $id, isOffer: $isOffer, postId: $postId, createdAt: $createdAt, userId: $userId, userImageUrl: $userImageUrl, username: $username)';
  }

  CommentModel operator <<(dynamic other) {
    return CommentModel.fromMap(other);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentModel &&
        other.content == content &&
        other.id == id &&
        other.isOffer == isOffer &&
        other.postId == postId &&
        other.createdAt == createdAt &&
        other.userId == userId &&
        other.userImageUrl == userImageUrl &&
        other.username == username;
  }

  @override
  int get hashCode {
    return content.hashCode ^
        id.hashCode ^
        isOffer.hashCode ^
        postId.hashCode ^
        createdAt.hashCode ^
        userId.hashCode ^
        userImageUrl.hashCode ^
        username.hashCode;
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
}
