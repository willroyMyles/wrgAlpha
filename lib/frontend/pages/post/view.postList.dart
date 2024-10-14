import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/frontend/atoms/atom.customListVIew.dart';
import 'package:wrg2/frontend/pages/post/state.posts.dart';
import 'package:wrg2/frontend/pages/post/view.postItem.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostState>(
      initState: (_) {},
      builder: (_) {
        return CustomListView<PostModel>(
            loadMore: _.loadMore,
            reset: _.setup,
            header: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Parts Needed", style: TS.h1))
              ],
            ),
            builder: (model) {
              var index = _.list.indexOf(model);

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
            hasMorePosts: !_.noMorePosts.value,
            items: _.list,
            con: _.scroll);
      },
    );
  }
}
