import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/pages/personal/state.personalPosts.dart';
import 'package:wrg2/frontend/pages/post/view.postItem.dart';

class PersonalPosts extends StatelessWidget {
  PersonalPosts({super.key});
  final controller = Get.put(PersonalPostState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: WRGAppBar("hello world"),

      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const CupertinoSliverNavigationBar(
              largeTitle: Text("Your Posts"),
              // middle: Text("data"),
              heroTag: "post tag",
              // previousPageTitle: "Profile",
              // stretch: true,
              transitionBetweenRoutes: true,
              alwaysShowMiddle: true,

              border: Border(),
            ),
          ];
        },
        body: controller.obx(
          (state) => Container(
            child: ListView.builder(
              controller: controller.scroll,
              itemCount: controller.posts.length,
              itemBuilder: (context, index) {
                var item = controller.posts.elementAt(index);
                return PostItem(model: item);
              },
            ),
          ),
          onEmpty: Constants.empty,
          onLoading: Constants.loading,
        ),
      ),
    );
  }
}
