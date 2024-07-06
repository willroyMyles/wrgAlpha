import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wrg2/backend/models/service.model.dart';
import 'package:wrg2/backend/utils/util.formatter.dart';
import 'package:wrg2/backend/worker/worker.auth.dart';

mixin PostExecutor {
  final String _col = "services";
  final _fstore = FirebaseFirestore.instance;

  Future service_createPost(ServiceModel model) async {
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

  Future<List<ServiceModel>> service_getPosts({dynamic id}) async {
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
        var res = list.docs.map((e) => ServiceModel.fromMap(e.data())).toList();
        return res;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<ServiceModel>> service_getMyPosts({int? id}) async {
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
        var res = list.docs.map((e) => ServiceModel.fromMap(e.data())).toList();
        return res;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future service_incrimentViews(String id) async {
    try {
      _fstore
          .collection(_col)
          .doc(id)
          .update({"views": FieldValue.increment(1)});
    } catch (e) {
      print(e);
    }
  }

  Future<bool> service_modifyPost(String id, Map<String, dynamic> data) async {
    try {
      _fstore.collection(_col).doc(id).update(data);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  service_deletePost(String id) async {
    try {
      _fstore.collection(_col).doc(id).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
