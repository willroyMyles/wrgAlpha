// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  String toJson() => json.encode(toMap());

  factory MessagesModel.fromJson(String source) =>
      MessagesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessagesModel(sender: $sender, content: $content, id: $id, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessagesModel &&
        other.sender == sender &&
        other.content == content &&
        other.id == id &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return sender.hashCode ^
        content.hashCode ^
        id.hashCode ^
        createdAt.hashCode;
  }
}
