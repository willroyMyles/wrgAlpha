import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/utils/util.snackbars.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class WatchingState extends GetxController with StateMixin {
  List<PostModel> posts = [];
  @override
  void onInit() {
    super.onInit();
    setup();
  }

  Future setup() async {
    var list =
        List<String>.from(GFI<ProfileState>()?.userModel?.value.watching ?? []);
    List<DocumentReference> refs =
        list.map((e) => FirebaseFirestore.instance.doc("posts/$e")).toList();

    var docs = await Future.wait(refs.map((e) => e.get()));
    posts = docs
        .where((e) => e.exists)
        .map((e) => PostModel.fromMap(e.data() as dynamic))
        .toList();
    change(docs, status: RxStatus.success());
  }

  void clearAll() async {
    var res = await GF<GE>().user_clearWatching();
    if (res) {
      posts.clear();
      refresh();
      change(posts, status: RxStatus.empty());
      SBUtil.showSuccessSnackBar("Cleared bookmarks");
    } else {
      SBUtil.showErrorSnackBar("Failed to clear bookmarks");
    }
  }
}
