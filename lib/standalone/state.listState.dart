import 'package:get/get.dart';
import 'package:wrg2/backend/models/model.dart';

abstract class ListState<T extends Model> extends GetxController
    with ScrollMixin {
  RxList<T> list = RxList([]);
  RxInt lastLength = 0.obs;
  RxBool noMorePosts = false.obs;
  final limit = 20;

  Future<List<T>> getModel() async {
    return [];
  }

  Future<List<T>> getMoreModel() async {
    return [];
  }

  @override
  void onInit() {
    super.onInit();
    setup();
  }

  setup() async {
    try {
      list.clear();
      noMorePosts.value = false;
      var ans = await getModel();
      list.addAll(ans);
      if (ans.length < limit) noMorePosts.value = true;
      lastLength.value = list.length;
      refresh();
    } catch (e) {
      print(e);
    }
  }

  addPost(T model) {
    list.insert(0, model);
    refresh();
  }

  loadMore() async {
    try {
      if (noMorePosts.value) return;
      var ans = await getModel();
      list.addAll(ans);

      noMorePosts.value = lastLength.value == list.length;
      if (ans.length < limit) noMorePosts.value = true;

      lastLength.value = list.length;
      // posts.refresh();
      refresh();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> onEndScroll() async {
    print("bottom reaxhed");
    if (noMorePosts.value) return;
    loadMore();
  }

  @override
  Future<void> onTopScroll() async {
    print("top reaxhed");
  }
}
