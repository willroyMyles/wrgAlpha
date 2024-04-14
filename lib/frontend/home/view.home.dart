import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/atoms/atom.offer.dart';
import 'package:wrg2/frontend/atoms/atom.watchingAtom.dart';
import 'package:wrg2/frontend/post/state.posts.dart';
import 'package:wrg2/frontend/post/view.createPost.dart';
import 'package:wrg2/frontend/post/view.postList.dart';
import 'package:wrg2/frontend/profile/state.profile.dart';
import 'package:wrg2/frontend/profile/view.profile.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final postState = Get.put(PostState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreatePost());
        },
        child: const Text("Add"),
      ),
      drawer: const Drawer(
        child: ProfileView(),
      ),
      body: SafeArea(
        child: GetBuilder<ProfileState>(
          initState: (_) {
            print("initiated");
          },
          builder: (controller) {
            return Container(
              padding: Constants.ePadding,
              child: Column(children: [
                Container(
                    alignment: Alignment.center,
                    padding: Constants.ePadding,
                    child: Builder(builder: (context) {
                      if (controller.userModel?.value == null) {
                        return IconButton(
                          icon: const Icon(
                            CupertinoIcons.person_alt_circle,
                            size: 35,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      } else {
                        return Hero(
                          tag: "profile icon",
                          child: Container(
                              height: 55,
                              width: 55,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100)),
                              child: InkWell(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: CircleAvatar(
                                  radius: 35,
                                  child: Obx(() => Image.network(controller
                                      .userModel!.value.userImageUrl)),
                                ),
                              )),
                        );
                      }
                    })),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: WatchingAtom()),
                    SizedBox(width: 10),
                    Expanded(child: OffersAtom()),
                  ],
                ),
                Expanded(
                    child: Obx(() =>
                        PostList(items: postState.posts.values.toList()))),
              ]),
            );
          },
        ),
      ),
    );
  }
}
