import 'package:get/get.dart';
import 'package:wrg2/backend/models/model.dart';

abstract class ListState<T extends Model> extends GetxController
    with ScrollMixin {
  RxList<T> list = RxList([]);
  RxInt lastLength = 0.obs;
  RxBool noMorePosts = false.obs;

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
      var ans = await getMoreModel();
      list.addAll(ans);

      noMorePosts.value = lastLength.value == list.length;

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
    loadMore();
  }

  @override
  Future<void> onTopScroll() async {
    print("top reaxhed");
  }
}
