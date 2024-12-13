import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/frontend/atoms/atom.customListVIew.dart';
import 'package:wrg2/frontend/pages/post/view.postItem.dart';
import 'package:wrg2/standalone/state.listState.dart';

class DiscoverState extends ListState<PostModel> {
  @override
  Future<List<PostModel>> getModel() async {
    var ans = await Get.find<GE>().posts_getAllPosts();
    return ans;
  }

  @override
  Future<List<PostModel>> getMoreModel() async {
    var ans = await Get.find<GE>().posts_getAllPosts(
      id: list.lastOrNull?.createdAt?.millisecondsSinceEpoch,
    );
    return ans;
  }
}

class DiscoverList extends GetView<DiscoverState> {
  const DiscoverList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiscoverState>(
      initState: (_) {},
      builder: (_) {
        return CustomListView<PostModel>(
            loadMore: _.loadMore,
            reset: _.setup,
            header: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Requests",
                    style: TS.h1,
                  ),
                )
              ],
            ),
            builder: (model) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: model.id,
                    child: Material(
                        color: Colors.transparent,
                        child: PostItem(model: model)),
                  ),
                ],
              );
            },
            items: _.list,
            con: _.scroll);
      },
    );
  }
}
