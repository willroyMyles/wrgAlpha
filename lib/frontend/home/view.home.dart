import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/home/view.navbar.dart';
import 'package:wrg2/frontend/pages/post/state.posts.dart';
import 'package:wrg2/frontend/pages/post/state.service.dart';
import 'package:wrg2/frontend/pages/post/view.createPost.dart';
import 'package:wrg2/frontend/pages/post/view.postList.dart';
import 'package:wrg2/frontend/pages/post/view.serviceList.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';
import 'package:wrg2/frontend/pages/profile/view.profile.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final postState = Get.put(PostState());
  final serviceState = Get.put(ServiceState());
  PageController pg = PageController();

  RxInt currentIndex = 0.obs;

  _buildIcon(IconData icon, String label, int index) {
    return Obx(() {
      var selected = currentIndex.value == index;
      var size = selected ? 57.0 : 55.0;
      return Tooltip(
        message: label,
        enableTapToDismiss: true,
        triggerMode: TooltipTriggerMode.longPress,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(10),
          clipBehavior: Clip.antiAlias,
          width: size,
          height: size,
          decoration: BoxDecoration(
              color: selected
                  ? Colors.black.withOpacity(1)
                  : Colors.white.withOpacity(1),
              border: Border.all(
                  color: selected
                      ? toc.primaryColor
                      : Colors.black.withOpacity(.1),
                  width: 1),
              borderRadius: BorderRadius.circular(size)),
          child: InkWell(
            borderRadius: BorderRadius.circular(size),
            onTap: () {
              currentIndex.value = index;
              pg.jumpToPage(index);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: selected
                      ? toc.primaryColor.lighter.lighter
                      : Colors.black.withOpacity(.6),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ProfileView(),
      ),
      appBar: AppBar(
        // "Welcome",
        // additional: Text(
        //   GF<ProfileState>().userModel?.value.email ?? "",
        //   textScaler: const TextScaler.linear(.5),
        // ),
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
                      child: Image.network(
                        GF<ProfileState>().userModel!.value.userImageUrl,
                        fit: BoxFit.scaleDown,
                        height: 20,
                        width: 20,
                      )),
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
          Obx(() => GF<ProfileState>().isSignedIn.value
              ? buildPopup(
                  Container(
                      padding: EdgeInsets.only(right: Constants.cardpadding),
                      child: const Icon(
                        Icons.add_circle_outline,
                        // color: toc.primaryColor,
                      )),
                  [
                      TextButton(
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
                          )),
                      TextButton(
                          onPressed: () {
                            Get.close(1);

                            Get.to(() => CreatePost(), arguments: {
                              "isService": true,
                            });
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.room_service_outlined),
                              SizedBox(width: 5),
                              Text("Request Service")
                            ],
                          )),
                    ])
              : GetBuilder<ProfileState>(
                  builder: (_) {
                    if (_.userModel == null) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                    );
                  },
                ))
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: Obx(() => WrgNavBar(
            selectedIndex: currentIndex.value,
            items: [
              WrgNavBarItem(
                  title: "Parts",
                  icon: CupertinoIcons.wrench,
                  onTap: () {
                    currentIndex.value = 0;
                    pg.jumpToPage(0);
                  }),
              WrgNavBarItem(
                  title: "Services",
                  icon: CupertinoIcons.circle_grid_hex,
                  onTap: () {
                    currentIndex.value = 1;
                    pg.jumpToPage(1);
                  }),
              WrgNavBarItem(
                  title: "Profile",
                  icon: CupertinoIcons.profile_circled,
                  onTap: () {
                    currentIndex.value = 2;
                    pg.jumpToPage(2);
                  }),
            ],
          )),
      // floatingActionButton: SizedBox(
      //   height: 63,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       _buildIcon(CupertinoIcons.wrench, "Parts", 0),
      //       _buildIcon(CupertinoIcons.circle_grid_hex, "Services", 1),
      //     ],
      //   ),
      // ),

      body: PageView(
        // controller: PageController(),
        controller: pg,
        allowImplicitScrolling: false,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          currentIndex.value = index;
        },
        children: [
          const PostList(),
          const ServiceList(),
          ProfileView(show: false)
        ],
      ),
    );
  }
}
