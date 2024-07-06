import 'dart:convert';

class ServiceModel {
  String id = "";
  String title = "";
  String content = "";
  String make = "";
  String model = "";
  String? category;
  int year = 0;
  int views = 0;
  DateTime? createdAt;
  String userEmail;
  String userName;
  String userPhotoUrl;
  ServiceModel({
    this.id = '',
    this.title = '',
    this.content = '',
    this.make = '',
    this.model = '',
    this.category,
    this.year = 0,
    this.views = 0,
    this.createdAt,
    this.userEmail = '',
    this.userName = '',
    this.userPhotoUrl = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'make': make,
      'model': model,
      'category': category,
      'year': year,
      'views': views,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'userEmail': userEmail,
      'userName': userName,
      'userPhotoUrl': userPhotoUrl,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      make: map['make'] ?? '',
      model: map['model'] ?? '',
      category: map['category'],
      year: map['year']?.toInt() ?? 0,
      views: map['views']?.toInt() ?? 0,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      userEmail: map['userEmail'] ?? '',
      userName: map['userName'] ?? '',
      userPhotoUrl: map['userPhotoUrl'] ?? '',
    );
  }

  factory ServiceModel.fromJson(String source) =>
      ServiceModel.fromMap(json.decode(source));
}
