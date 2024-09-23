// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/models/rating.model.dart';

class UserInfoModel {
  String username;
  String userImageUrl;
  String userId;
  String email;
  String? alias;
  String? mobile;

  List<String> watching;
  List<RatingModel> ratings;

  UserInfoModel({
    this.username = '',
    this.userImageUrl = '',
    this.userId = '',
    this.email = '',
    this.alias = '',
    this.mobile,
    this.watching = const [],
    this.ratings = const [],
  });
  Map<String, String> watchingMap = {};

  factory UserInfoModel.empty() => UserInfoModel();

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'userImageUrl': userImageUrl,
      'userId': userId,
      'email': email,
      'alias': alias,
      'mobile': mobile,
      'watching': watching,
      'ratings': ratings.map((x) => x.toMap()).toList(),
    };
  }

  factory UserInfoModel.fromMapForConvo(Map<String, dynamic> json) {
    var userinfo = UserInfoModel.empty();
    return userinfo;
  }

  factory UserInfoModel.fromMap(Map<String, dynamic> map) {
    return UserInfoModel(
      username: map['username'] ?? '',
      userImageUrl: map['userImageUrl'] ?? '',
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      alias: map['alias'],
      mobile: map['mobile'],
      watching: List<String>.from(map['watching'] ?? const []),
      ratings: List<RatingModel>.from(
          map['ratings']?.map((x) => RatingModel.fromMap(x)) ?? const []),
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
