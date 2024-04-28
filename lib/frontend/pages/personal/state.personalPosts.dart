import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';

class PersonalPostState extends GetxController with StateMixin {
  RxList<PostModel> posts = RxList([]);
  late ScrollController scroll;
  @override
  void onInit() {
    super.onInit();
    setup();

    scroll = ScrollController(
      onAttach: (position) {
        print("attached");
        scroll.addListener(
          () {
            print("listening");
          },
        );
      },
      onDetach: (position) {
        print("object");
      },
    );
  }

  Future setup() async {
    var pts = await GF<GE>().posts_getMyPosts();
    posts.addAll(pts);
    change("", status: RxStatus.success());

    if (posts.isEmpty) change(null, status: RxStatus.empty());
  }

  void well() {
    print("well");
  }
}
