import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nanoid2/nanoid2.dart';
import 'package:wrg2/backend/models/post.model.dart';

mixin PostExecutor {
  final String _col = "posts";
  final _fstore = FirebaseFirestore.instance;

  Future posts_createPost(PostModel model) async {
    try {
      var id = nanoid(length: 7);
      model.id = id;
      await _fstore.collection(_col).doc(id).set(model.toMap());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
