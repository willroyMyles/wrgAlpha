import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/frontend/atoms/atom.customListVIew.dart';
import 'package:wrg2/frontend/pages/post/state.posts.dart';
import 'package:wrg2/frontend/pages/post/view.postItem.dart';

class PostList extends StatelessWidget {
  final bool hasMorePosts;
  const PostList({super.key, required this.hasMorePosts});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostState>(
      initState: (_) {},
      builder: (_) {
        return CustomListView(
            loadMore: _.loadMore,
            reset: _.setup,
            header: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Parts Wanted",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            builder: (model) {
              var index = _.posts.indexOf(model);

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: model.id,
                    child: Material(child: PostItem(model: model)),
                  ),
                  if (!hasMorePosts && index == _.posts.length - 1)
                    const SizedBox(
                        height: 100,
                        child: Center(child: Text("No more posts"))),
                ],
              );
            },
            items: _.posts,
            hasMorePosts: hasMorePosts,
            con: _.scroll);

        return RefreshIndicator(
            onRefresh: () async {
              await _.setup();
            },
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _.posts.length,
                itemBuilder: (context, index) {
                  var model = _.posts.elementAt(index);

                  if (index == _.posts.length - 1 && !hasMorePosts) {
                    _.loadMore();
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Hero(
                        tag: model.id,
                        child: Material(child: PostItem(model: model)),
                      ),
                      if (!hasMorePosts && index == _.posts.length - 1)
                        const SizedBox(
                            height: 100,
                            child: Center(child: Text("No more posts"))),
                    ],
                  );
                },
              ),
            ));
      },
    );
  }
}
