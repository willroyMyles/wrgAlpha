import 'package:automatic_animated_list/automatic_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';
import 'package:wrg2/frontend/pages/post/view.postItem.dart';
import 'package:wrg2/frontend/pages/watching/state.watching.dart';

class WatchingView extends StatelessWidget {
  WatchingView({super.key});
  final controller = Get.put(WatchingState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: WRGAppBar("hello world"),

      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const WRGAppBar("Posts You've Bookmarked"),
            SliverToBoxAdapter(
              child: GetBuilder<WatchingState>(
                init: controller,
                initState: (_) {},
                builder: (_) {
                  return Row(
                    children: [
                      // if (controller.posts.isNotEmpty)
                      TextButton(
                          onPressed: () {
                            controller.clearAll();
                          },
                          child: const Text("Clear all bookmarks"))
                    ],
                  );
                },
              ),
            )
          ];
        },
        body: SafeArea(
          child: controller.obx(
            (state) => Container(
              padding: const EdgeInsets.only(top: 40),
              child: AutomaticAnimatedList(
                  padding: EdgeInsets.zero,
                  items: controller.posts,
                  itemBuilder: (p0, p1, p2) {
                    var model = p1;
                    var idx = controller.posts.indexOf(model);

                    return FadeTransition(
                        opacity: p2,
                        child: Column(
                          children: [
                            Hero(
                              tag: model.id,
                              child: Material(
                                  color: Colors.transparent,
                                  child: PostItem(model: model)),
                            ),
                          ],
                        ));
                  },
                  keyingFunction: (id) => ValueKey(id)),
            ),
            onEmpty: Constants.emptyWidget("No Bookmarks"),
            onLoading: Constants.loading,
          ),
        ),
      ),
    );
  }
}
