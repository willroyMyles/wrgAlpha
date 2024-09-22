import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/models/post.model.dart';

class WatchingState extends GetxController with StateMixin {
  List<PostModel> posts = [];
  @override
  void onInit() {
    super.onInit();
    setup();
  }

  Future setup() async {
    var list = List<String>.from(Get.arguments['list'] ?? []);
    List<DocumentReference> refs =
        list.map((e) => FirebaseFirestore.instance.doc("posts/$e")).toList();

    var docs = await Future.wait(refs.map((e) => e.get()));
    posts = docs
        .where((e) => e.exists)
        .map((e) => PostModel.fromMap(e.data() as dynamic))
        .toList();
    change(docs, status: RxStatus.success());
  }
}
