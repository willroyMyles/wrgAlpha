import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
