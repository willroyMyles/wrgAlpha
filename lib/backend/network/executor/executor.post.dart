import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/utils/util.formatter.dart';
import 'package:wrg2/backend/worker/worker.auth.dart';

mixin PostExecutor {
  final String _col = "posts";
  final _fstore = FirebaseFirestore.instance;

  Future posts_createPost(PostModel model) async {
    try {
      var id =
          "${model.userEmail.parseEmail}-${model.createdAt!.formatDateForPost()}";
      model.id = id;
      await _fstore.collection(_col).doc(id).set(model.toMap());

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<PostModel>> posts_getPosts({dynamic id}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> list;
      if (id == null) {
        list = await _fstore
            .collection(_col)
            .limit(2)
            .orderBy("createdAt", descending: true)
            .get();
      } else {
        list = await _fstore
            .collection(_col)
            .limit(2)
            .orderBy("createdAt", descending: true)
            .startAfter([id]).get();
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

  Future<List<PostModel>> posts_getMyPosts({int? id}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> list;
      if (id == null) {
        list = await _fstore
            .collection(_col)
            .limit(20)
            .orderBy("createdAt", descending: true)
            .where("userEmail", isEqualTo: authWorker.user!.value.email)
            .get();
      } else {
        list = await _fstore
            .collection(_col)
            .limit(20)
            .orderBy("createdAt")
            .where("userEmail", isEqualTo: authWorker.user!.value.email)
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
