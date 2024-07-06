import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.snackbars.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';
import 'package:wrg2/frontend/atoms/atom.box.dart';
import 'package:wrg2/frontend/pages/offers/state.offers.dart';
import 'package:wrg2/frontend/pages/offers/view.offers.dart';
import 'package:wrg2/frontend/pages/post/state.posts.dart';
import 'package:wrg2/frontend/pages/post/view.createPost.dart';
import 'package:wrg2/frontend/pages/post/view.postList.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';
import 'package:wrg2/frontend/pages/profile/view.profile.dart';
import 'package:wrg2/frontend/pages/watching/view.watching.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final postState = Get.put(PostState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ProfileView(),
      ),
      body: NestedScrollView(
          controller: postState.scroll,
          headerSliverBuilder: (context, _) {
            return [
              WRGAppBar(
                "Welcome",
                additional: Text(
                  GF<ProfileState>().userModel?.value.email ?? "",
                  textScaler: const TextScaler.linear(.5),
                ),
                leading: Builder(builder: (context) {
                  return Obx(() => GF<ProfileState>().isSignedIn.value
                      ? InkWell(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Container(
                              margin: const EdgeInsets.all(5),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Image.network(GF<ProfileState>()
                                  .userModel!
                                  .value
                                  .userImageUrl)),
                        )
                      : IconButton(
                          icon: const Icon(
                            CupertinoIcons.person_alt_circle,
                            size: 35,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ));
                }),
                actions: [
                  buildPopup(
                      Container(
                          padding:
                              EdgeInsets.only(right: Constants.cardpadding),
                          child: Icon(
                            Icons.add_circle_outline,
                            color: toc.primaryColor,
                          )),
                      [
                        Obx(() => GF<ProfileState>().isSignedIn.value
                            ? TextButton(
                                onPressed: () {
                                  Get.close(1);

                                  Get.to(() => CreatePost());
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.post_add),
                                    SizedBox(width: 5),
                                    Text("Request Car Part")
                                  ],
                                ))
                            : Container()),
                        Obx(() => GF<ProfileState>().isSignedIn.value
                            ? TextButton(
                                onPressed: () {
                                  Get.close(1);
                                  // Get.to(() => CreatePost());
                                  SBUtil.showInfoSnackBar(
                                      "This feature is not yet available");
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.room_service_outlined),
                                    SizedBox(width: 5),
                                    Text("Request Service")
                                  ],
                                ))
                            : Container()),
                      ])
                ],
              ),
              SliverToBoxAdapter(
                child: GetBuilder<ProfileState>(
                  builder: (_) {
                    if (_.userModel == null) {
                      return Row(
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
                      );
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
                          InkWell(
                            onTap: () {
                              Get.to(() => WatchingView(), arguments: {
                                "list": _.userModel?.value.watching
                              });
                            },
                            child: AtomBox(
                              value: _.userModel?.value.watching.length ?? 0,
                              label: "Bookmarks",
                            ),
                          ),
                          SizedBox(width: Constants.cardMargin),
                          GetBuilder<OfferState>(
                            builder: (_) {
                              return InkWell(
                                onTap: () {
                                  Get.to(() => const OffersView());
                                },
                                child: AtomBox(
                                  value: _.models.length,
                                  label: "Offers",
                                ),
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
                hasMorePosts: !postState.noMorePosts.value,
              ))),
    );
  }
}
