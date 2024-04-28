// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class MessagesModel {
  String sender;
  String content;
  String id;
  MessagesModel({
    this.sender = '',
    this.content = '',
    this.id = '',
  });
  DateTime createdAt = DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'content': content,
      'id': id,
    };
  }

  factory MessagesModel.fromMap(Map<String, dynamic> map) {
    return MessagesModel(
      sender: (map['sender'] ?? '') as String,
      content: (map['content'] ?? '') as String,
      id: (map['id'] ?? '') as String,
    );
  }

  factory MessagesModel.empty() => MessagesModel();

  bool amISender() {
    var state = GF<ProfileState>();
    if (state.userModel == null) return false;
    return state.userModel!.value.email == sender;
  }
}
