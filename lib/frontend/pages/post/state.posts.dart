import 'package:get/get.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';

class PostState extends GetxController with ScrollMixin {
  RxList<PostModel> posts = RxList([]);
  RxInt lastLength = 0.obs;
  RxBool noMorePosts = false.obs;
  final limit = 20;

  @override
  void onInit() {
    super.onInit();
    setup();
  }

  setup() async {
    try {
      posts.clear();
      noMorePosts.value = false;
      var ans = await Get.find<GE>().posts_getPosts(limit: limit);
      posts.addAll(ans);
      if (ans.length < limit) noMorePosts.value = true;
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
          limit: limit);
      posts.addAll(ans);

      noMorePosts.value = lastLength.value == posts.length;
      if (ans.length < limit) noMorePosts.value = true;

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
