import 'package:get/get.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';

class PostState extends GetxController {
  RxMap<String, PostModel> posts = RxMap({});

  @override
  void onInit() {
    super.onInit();
    setup();
  }

  setup() async {
    try {
      var ans = await Get.find<GE>().posts_getPosts();
      for (var element in ans) {
        posts.update(element.id, (value) => element, ifAbsent: () => element);
      }
      posts.refresh();
      refresh();
    } catch (e) {
      print(e);
    }
  }
}
