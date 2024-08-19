import 'package:get/get.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/standalone/state.listState.dart';

class ServiceState extends ListState<PostModel> {
  @override
  Future<List<PostModel>> getModel() async {
    var ans = await Get.find<GE>().posts_getPosts(isService: true);
    return ans;
  }

  @override
  Future<List<PostModel>> getMoreModel() async {
    var ans = await Get.find<GE>().posts_getPosts(
        id: list.lastOrNull?.createdAt?.millisecondsSinceEpoch,
        isService: true);
    return ans;
  }
}
