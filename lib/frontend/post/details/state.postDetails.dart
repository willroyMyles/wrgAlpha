import 'package:get/get.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/frontend/post/state.posts.dart';
import 'package:wrg2/frontend/profile/state.profile.dart';

class PostDetailsState extends GetxController {
  late PostModel model;

  onWatching() async {
    var user = Get.find<ProfileState>().userModel;
    if (user.isNull) {
      //throw error
      return;
    }

    var isWatching = user!.value.watching.contains(model.id);

    var res =
        await Get.find<GE>().user_modifyWatching(model.id, add: !isWatching);

    //add to watching
    if (res) {
      var state = Get.find<PostState>();
      if (isWatching) {
        user.value.watching.remove(model.id);
        model.watching = model.watching - 1;
      } else {
        user.value.watching.add(model.id);
        model.watching = model.watching + 1;
      }
      state.posts[model.id] = model;
    } else {
      //throw error
    }

    getArgs();
    refresh();
  }

  @override
  void onInit() {
    super.onInit();
    getArgs();
    Get.find<GE>().posts_incrimentViews(model.id);
  }

  getArgs() {
    var id = Get.arguments['id'];
    model = Get.find<PostState>().posts[id!]!;
  }
}
