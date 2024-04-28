import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movements/support/widget.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/atoms/atom.box.dart';
import 'package:wrg2/frontend/atoms/atom.offer.dart';
import 'package:wrg2/frontend/atoms/atom.watchingAtom.dart';
import 'package:wrg2/frontend/pages/offers/state.offers.dart';
import 'package:wrg2/frontend/pages/post/state.posts.dart';
import 'package:wrg2/frontend/pages/post/view.createPost.dart';
import 'package:wrg2/frontend/pages/post/view.postList.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';
import 'package:wrg2/frontend/pages/profile/view.profile.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final postState = Get.put(PostState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: ProfileView(),
      ),
      body: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              // const CupertinoSliverNavigationBar(
              //   largeTitle: Text("Your Feed"),
              //   leading: Text("leading"),
              //   stretch: true,
              //   transitionBetweenRoutes: true,
              //   alwaysShowMiddle: false,
              // ),
              SliverAppBar.medium(
                title: const Text(
                  "Your Feed",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                centerTitle: false,
                backgroundColor: lightBackgroundColor,
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.to(() => CreatePost());
                      },
                      icon: const Icon(Icons.my_library_add_outlined))
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(
                    left: Constants.cardMargin,
                    right: Constants.cardMargin,
                    top: Constants.cardMargin,
                    bottom: Constants.cardMargin,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GetBuilder<ProfileState>(
                        builder: (_) {
                          return Obx(() => AtomBox(
                                value: _.userModel?.value.watching.length ?? 0,
                                label: "Watching",
                              ));
                        },
                      ),
                      SizedBox(width: Constants.cardMargin),
                      GetBuilder<OfferState>(
                        builder: (_) {
                          return Obx(() => AtomBox(
                                value: _.models.length,
                                label: "Offers",
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: Obx(() => PostList(items: postState.posts.values.toList()))),
    );
    return Scaffold(
      floatingActionButton: MovementWidget(
        keyy: "fab",
        isAlreadyHero: true,
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => CreatePost());
          },
          child: const Text("Add"),
        ),
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
                const MovementWidget(
                  keyy: "top options",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: WatchingAtom()),
                      SizedBox(width: 10),
                      Expanded(child: OffersAtom()),
                    ],
                  ),
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
