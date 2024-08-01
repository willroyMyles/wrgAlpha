import 'package:get/get.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';

class ServiceState extends GetxController with ScrollMixin {
  RxList<PostModel> posts = RxList([]);
  RxInt lastLength = 0.obs;
  RxBool noMorePosts = false.obs;

  @override
  void onInit() {
    super.onInit();
    setup();
  }

  setup() async {
    try {
      posts.clear();
      noMorePosts.value = false;
      var ans = await Get.find<GE>().posts_getPosts(isService: true);
      posts.addAll(ans);
      lastLength.value = posts.length;
      refresh();
    } catch (e) {
      print(e);
    }
  }

  addPost(PostModel model) {
    posts.insert(0, model);
    refresh();
  }

  loadMore() async {
    try {
      if (noMorePosts.value) return;
      var ans = await Get.find<GE>().posts_getPosts(
          id: posts.lastOrNull?.createdAt?.millisecondsSinceEpoch,
          isService: true);
      posts.addAll(ans);

      noMorePosts.value = lastLength.value == posts.length;

      lastLength.value = posts.length;
      // posts.refresh();
      refresh();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> onEndScroll() async {
    print("bottom reaxhed");
    loadMore();
  }

  @override
  Future<void> onTopScroll() async {
    print("top reaxhed");
  }
}
