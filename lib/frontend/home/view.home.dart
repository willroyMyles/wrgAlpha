import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/home/view.navbar.dart';
import 'package:wrg2/frontend/pages/post/view.list.dart';
import 'package:wrg2/frontend/pages/profile/view.profile.dart';

class HomeViewController extends GetxController {
  RxInt currentIndex = 0.obs;
}

class HomeView extends StatelessWidget {
  HomeView({super.key});
  // final postState = Get.put(PostState());
  final discoverState = Get.put(DiscoverState());
  PageController pg = PageController();
  final HomeViewController hvc = Get.put(HomeViewController());

  // _buildIcon(IconData icon, String label, int index) {
  //   return Obx(() {
  //     var selected = hvc.currentIndex.value == index;
  //     var size = selected ? 57.0 : 55.0;
  //     return Tooltip(
  //       message: label,
  //       enableTapToDismiss: true,
  //       triggerMode: TooltipTriggerMode.longPress,
  //       child: AnimatedContainer(
  //         duration: const Duration(milliseconds: 150),
  //         margin: const EdgeInsets.symmetric(horizontal: 8),
  //         padding: const EdgeInsets.all(10),
  //         clipBehavior: Clip.antiAlias,
  //         width: size,
  //         height: size,
  //         decoration: BoxDecoration(
  //             color: selected
  //                 ? Colors.black.withOpacity(1)
  //                 : Colors.white.withOpacity(1),
  //             border: Border.all(
  //                 color: selected
  //                     ? toc.primaryColor
  //                     : Colors.black.withOpacity(.1),
  //                 width: 1),
  //             borderRadius: BorderRadius.circular(size)),
  //         child: InkWell(
  //           borderRadius: BorderRadius.circular(size),
  //           onTap: () {
  //             hvc.currentIndex.value = index;
  //             pg.jumpToPage(index);
  //           },
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Icon(
  //                 icon,
  //                 size: 30,
  //                 color: selected
  //                     ? toc.primaryColor.lighter.lighter
  //                     : Colors.black.withOpacity(.6),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ProfileView(),
      ),

      appBar: AppBar(
        toolbarHeight: 10,
        leading: Builder(builder: (context) {
          return Container();
        }),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: AnnotatedRegion<SystemUiOverlayStyle>(
        value: toc.appBarTheme.systemOverlayStyle!,
        child: Obx(() => WrgNavBar(
              selectedIndex: hvc.currentIndex.value,
              items: [
                WrgNavBarItem(
                    title: "Requests",
                    icon: CupertinoIcons.square_stack_3d_down_right,
                    onTap: () {
                      hvc.currentIndex.value = 0;
                      pg.jumpToPage(0);
                    }),
                // WrgNavBarItem(
                //     title: "Services",
                //     icon: CupertinoIcons.tray,
                //     onTap: () {
                //       hvc.currentIndex.value = 1;
                //       pg.jumpToPage(1);
                //     }),
                WrgNavBarItem(
                    title: "Profile",
                    icon: CupertinoIcons.profile_circled,
                    onTap: () {
                      hvc.currentIndex.value = 1;
                      pg.jumpToPage(1);
                    }),
              ],
            )),
      ),

      body: PageView(
        // controller: PageController(),
        controller: pg,
        allowImplicitScrolling: false,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          hvc.currentIndex.value = index;
        },
        children: [
          // const PostList(),
          // const ServiceList(),
          DiscoverList(),
          ProfileView(show: false)
        ],
      ),
    );
  }
}
