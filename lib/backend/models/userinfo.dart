// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:wrg2/backend/models/conversation.dart';
import 'package:wrg2/backend/models/post.model.dart';

class UserInfoModel {
  String username;
  String userImageUrl;
  String userId;
  String email;
  String alias;

  List<String> watching;
  List<String> incomings;
  List<String> outgoings;

  UserInfoModel({
    this.username = '',
    this.userImageUrl = '',
    this.userId = '',
    this.email = '',
    this.alias = '',
    this.watching = const [],
    this.incomings = const [],
    this.outgoings = const [],
  });
  Map<String, String> watchingMap = {};

  factory UserInfoModel.empty() => UserInfoModel();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'userImageUrl': userImageUrl,
      'userId': userId,
      'email': email,
      'alias': alias,
      'watching': watching,
      'incomings': incomings,
      'outgoings': outgoings,
    };
  }

  factory UserInfoModel.fromMapForConvo(Map<String, dynamic> json) {
    var userinfo = UserInfoModel.empty();

    userinfo.incomings =
        json["incomings"].map((e) => ConversationModel.fromMap(e)).toList();
    userinfo.outgoings =
        json["outgoings"].map((e) => ConversationModel.fromMap(e)).toList();

    return userinfo;
  }

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      username: (map['username'] ?? '') as String,
      userImageUrl: (map['userImageUrl'] ?? '') as String,
      userId: (map['userId'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      alias: (map['alias'] ?? '') as String,
      watching: List<String>.from((map['watching'] ?? const <String>[])),
      incomings: List<String>.from((map['incomings'] ?? const <String>[])),
      outgoings: List<String>.from((map['outgoings'] ?? const <String>[])),
    );
  }

  factory UserInfoModel.forPost(Map<String, dynamic> map) {
    var u = UserInfoModel.empty();
    u.username = map["username"];
    u.userImageUrl = map["userImageUrl"];
    u.userId = map["userId"];

    return u;
  }

  String toJson() => json.encode(toMap());

  factory UserInfoModel.fromJson(String source) =>
      UserInfoModel.fromMap(json.decode(source));

  UserInfoModel operator <<(dynamic other) {
    var uim = UserInfoModel.fromMap(other);
    uim.populateMap();
    return uim;
  }

  addToWatching(PostModel post) {
    watching.add(post.id);
    watchingMap.putIfAbsent(post.id, () => post.id);
  }

  void removeFromWatch(PostModel post) {
    watching.remove(post.id);
    watchingMap.remove(post.id);
  }
}

extension on UserInfoModel {
  populateMap() {
    for (var item in watching) {
      watchingMap.putIfAbsent(item, () => item);
    }
  }
}
