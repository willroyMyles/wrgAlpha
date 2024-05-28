import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';
import 'package:wrg2/frontend/atoms/atom.box.dart';
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
          controller: postState.scroll,
          headerSliverBuilder: (context, _) {
            return [
              // const CupertinoSliverNavigationBar(
              //   largeTitle: Text("Your Feed"),
              //   leading: Text("leading"),
              //   stretch: true,
              //   transitionBetweenRoutes: true,
              //   alwaysShowMiddle: false,
              // ),
              WRGAppBar(
                "You're Feed  ",
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      CupertinoIcons.person_alt_circle,
                      size: 35,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.to(() => CreatePost());
                      },
                      icon: const Icon(Icons.my_library_add_outlined))
                ],
              ),

              SliverToBoxAdapter(
                child: GetBuilder<ProfileState>(
                  builder: (_) {
                    if (_.userModel.isNull) {
                      return Container(
                          child: Row(
                        children: [
                          SizedBox(width: Constants.cardpadding * 2),
                          InkWell(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Constants.cardpadding,
                                      vertical: Constants.cardpadding / 2),
                                  decoration: BoxDecoration(
                                      // color: toc.primaryColor.withOpacity(.1),
                                      // border: Border.all(
                                      //     color: toc.primaryColor, width: 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(color: toc.primaryColor),
                                  ))),
                          const Text(" to view more options.")
                        ],
                      ));
                    }
                    return Container(
                      margin: EdgeInsets.only(
                        left: Constants.cardMargin,
                        right: Constants.cardMargin,
                        top: Constants.cardMargin,
                        bottom: Constants.cardMargin,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AtomBox(
                            value: _.userModel?.value.watching.length ?? 0,
                            label: "Watching",
                          ),
                          SizedBox(width: Constants.cardMargin),
                          GetBuilder<OfferState>(
                            builder: (_) {
                              return AtomBox(
                                value: _.models.length,
                                label: "Offers",
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ];
          },
          body: Obx(() => PostList(
                items: postState.posts.values.toList(),
                hasMorePosts: !postState.noMorePosts.value,
              ))),
    );
  }
}
