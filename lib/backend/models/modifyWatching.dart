// ignore_for_file: public_member_api_docs, sort_constructors_first

class ModifyWatching {
  String post;
  String id;
  bool add;
  ModifyWatching({
    this.post = '',
    this.id = '',
    this.add = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'post': post,
      'id': id,
      'add': add,
    };
  }

  factory ModifyWatching.fromMap(Map<String, dynamic> map) {
    return ModifyWatching(
      post: (map['post'] ?? '') as String,
      id: (map['id'] ?? '') as String,
      add: (map['add'] ?? false) as bool,
    );
  }
}
