import 'package:get/get.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';

class PostState extends GetxController with ScrollMixin {
  Map<String, PostModel> posts = RxMap({});
  RxInt lastLength = 0.obs;
  RxBool noMorePosts = false.obs;

  @override
  void onInit() {
    super.onInit();
    setup();
  }

  List<String>? _sort() {
    try {
      var keys = posts.keys.toList();
      keys.sort((a, b) {
        return posts[a]!.createdAt!.compareTo(posts[b]!.createdAt!);
      });
      return keys;
    } catch (e) {
      return null;
    }
  }

  setup() async {
    try {
      var ans = await Get.find<GE>().posts_getPosts();
      for (var element in ans) {
        posts.update(element.id, (value) => element, ifAbsent: () => element);
      }

      lastLength.value = posts.length;

      refresh();
    } catch (e) {
      print(e);
    }
  }

  loadMore() async {
    try {
      if (noMorePosts.value) return;
      var ans = await Get.find<GE>().posts_getPosts(
          id: posts[_sort()?.first]?.createdAt?.millisecondsSinceEpoch);
      for (var element in ans) {
        posts.update(element.id, (value) => element, ifAbsent: () => element);
      }

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
