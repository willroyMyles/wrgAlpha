import 'package:automatic_animated_list/automatic_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/frontend/pages/post/state.posts.dart';
import 'package:wrg2/frontend/pages/post/view.postItem.dart';

class PostList extends StatelessWidget {
  final List<dynamic> items;
  final bool hasMorePosts;
  const PostList({super.key, required this.items, required this.hasMorePosts});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostState>(
      initState: (_) {},
      builder: (_) {
        return RefreshIndicator(
          onRefresh: () async {
            await _.setup();
          },
          child: AutomaticAnimatedList(
              padding: EdgeInsets.zero,
              items: items,
              itemBuilder: (p0, p1, p2) {
                var model = p1;
                var idx = items.indexOf(model);

                if (idx == items.length - 1 && !hasMorePosts) {
                  _.loadMore();
                }
                return FadeTransition(
                    opacity: p2,
                    child: Column(
                      children: [
                        Hero(
                          tag: model.id,
                          child: Material(child: PostItem(model: model)),
                        ),
                        if (!hasMorePosts && idx == items.length - 1)
                          const SizedBox(
                              height: 100,
                              child: Center(child: Text("No more posts"))),
                      ],
                    ));
              },
              keyingFunction: (id) => ValueKey(id)),
        );
      },
    );
  }
}
