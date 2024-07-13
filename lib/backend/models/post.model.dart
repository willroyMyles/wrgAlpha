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
  bool isService;
  PostModel({
    this.title = '',
    this.id = '',
    this.content = '',
    this.category = '',
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
    this.isService = false,
  }) {
    // createdAt = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'content': content,
      'category': category,
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
      'isService': isService,
    };
  }

  bool contains(Map<String, dynamic> map, String key) => map.containsKey(key);

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      title: map['title'] ?? '',
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      category: map['category'] ?? '',
      make: map['make'] ?? '',
      model: map['model'] ?? '',
      year: map['year']?.toInt() ?? 0,
      views: map['views']?.toInt() ?? 0,
      watching: map['watching']?.toInt() ?? 0,
      comments: map['comments']?.toInt() ?? 0,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      userEmail: map['userEmail'] ?? '',
      userName: map['userName'] ?? '',
      userPhotoUrl: map['userPhotoUrl'] ?? '',
      status: Status.values[map['status'] ?? 0],
      offers: List<String>.from(map['offers'] ?? const []),
      isService: map['isService'] ?? false,
    );
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
