// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:wrg2/backend/enums/enum.post.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class PostModel {
  String title = "";
  String id = "";
  String content = "";
  String category = "";
  String subCategory = "";
  String make = "";
  String model = "";
  int year = 0;
  int views = 0;
  int watching = 0;
  int comments = 0;
  DateTime? createdAt;
  String userEmail;
  String userName;
  String userPhotoUrl;
  // UserInfoModel? userInfo;
  //enum
  Status status = Status.OPEN;
  List<String> offers = [];
  PostModel({
    this.title = '',
    this.id = '',
    this.content = '',
    this.category = '',
    this.subCategory = '',
    this.make = '',
    this.model = '',
    this.year = 0,
    this.views = 0,
    this.watching = 0,
    this.comments = 0,
    this.createdAt,
    this.userEmail = '',
    this.userName = '',
    this.userPhotoUrl = '',
    this.status = Status.OPEN,
    this.offers = const [],
  }) {
    // createdAt = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'id': id,
      'content': content,
      'category': category,
      'subCategory': subCategory,
      'make': make,
      'model': model,
      'year': year,
      'views': views,
      'watching': watching,
      'comments': comments,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'userEmail': userEmail,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
      'status': status.index,
      'offers': offers,
    };
  }

  bool contains(Map<String, dynamic> map, String key) => map.containsKey(key);

  factory PostModel.fromMap(Map<String, dynamic> map) {
    var m = PostModel(
      title: (map['title'] ?? '') as String,
      id: (map['id'] ?? '') as String,
      content: (map['content'] ?? '') as String,
      category: (map['category'] ?? '') as String,
      subCategory: (map['subCategory'] ?? '') as String,
      make: (map['make'] ?? '') as String,
      model: (map['model'] ?? '') as String,
      year: (map['year'] ?? 0) as int,
      views: (map['views'] ?? 0) as int,
      watching: (map['watching'] ?? 0) as int,
      comments: (map['comments'] ?? 0) as int,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map['createdAt'] ?? 0))
          : null,
      userEmail: (map['userEmail'] ?? '') as String,
      userName: (map['userName'] ?? '') as String,
      userPhotoUrl: (map['userPhotoUrl'] ?? '') as String,
      status: Status.values[(map['status'] ?? 0) as int],
      offers: List<String>.from((map['offers'] ?? [])),
    );
    return m;
  }

  factory PostModel.fromMapWithoutUserinfo(Map<String, dynamic> map) {
    var cat = DateTime.parse(map["createdAt"]);
    var st = Status.values.firstWhere((element) {
      var name = element.name.toUpperCase();
      return name == map["status"];
    });
    // st ??= Status.OPEN;
    var p = PostModel(
      title: map['title'],
      id: map['id'],
      content: map['content'],
      category: map['category'],
      make: map['make'],
      model: map['model'],
      year: map['year'],
      views: map['views'],
      comments: map['commentss'],
      watching: map['watching'],
      status: st,
      createdAt: cat,
    );

    return p;
  }
  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  bool isWatching() {
    // var service = Get.find<InformationService>();
    // return service.watching.containsKey(id);
    return false;
  }

  bool amIOwner() {
    var ps = GF<ProfileState>();
    if (!ps.isSignedIn.value) {
      return false;
    }
    var ans = userEmail == ps.userModel?.value.email;
    return ans;
  }
}
