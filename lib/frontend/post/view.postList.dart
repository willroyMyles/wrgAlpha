import 'package:automatic_animated_list/automatic_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/frontend/post/state.posts.dart';
import 'package:wrg2/frontend/post/view.postItem.dart';

class PostList extends StatelessWidget {
  final List<dynamic> items;
  const PostList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostState>(
      initState: (_) {},
      builder: (_) {
        return AutomaticAnimatedList(
            items: items,
            itemBuilder: (p0, p1, p2) {
              var model = p1;
              return FadeTransition(opacity: p2, child: PostItem(model: model));
            },
            keyingFunction: (id) => ValueKey(id));
      },
    );
  }
}
