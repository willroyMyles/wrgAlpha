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

  Future<List<PostModel>> posts_getPosts({int? id}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> list;
      if (id == null) {
        list =
            await _fstore.collection(_col).limit(20).orderBy("createdAt").get();
      } else {
        list = await _fstore
            .collection(_col)
            .limit(20)
            .orderBy("createdAt")
            .startAt([id]).get();
      }

      if (list.size > 0) {
        var res = list.docs.map((e) => PostModel.fromMap(e.data())).toList();
        return res;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future posts_incrimentViews(String id) async {
    try {
      _fstore
          .collection(_col)
          .doc(id)
          .update({"views": FieldValue.increment(1)});
    } catch (e) {
      print(e);
    }
  }
}
