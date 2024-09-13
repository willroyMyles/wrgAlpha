import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.btns.dart';
import 'package:wrg2/backend/utils/util.snackbars.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/cars/view.cars.dart';
import 'package:wrg2/frontend/pages/messages/view.messages.dart';
import 'package:wrg2/frontend/pages/offers/state.offers.dart';
import 'package:wrg2/frontend/pages/offers/view.offers.dart';
import 'package:wrg2/frontend/pages/personal/view.personalPosts.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';
import 'package:wrg2/frontend/pages/watching/view.watching.dart';

class ProfileView extends GetView<ProfileState> {
  final bool show;
  ProfileView({super.key, this.show = true});
  RxBool showFeedback = false.obs;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Scaffold(
          body: SafeArea(
        child: Container(
          padding: Constants.ePadding,
          // alignment: Alignment.bottomCenter,
          child: GetBuilder<ProfileState>(
              init: controller,
              initState: (_) {},
              builder: (_) {
                return Obx(() => AnimatedSwitcher(
                    duration: 150.milliseconds,
                    layoutBuilder: (currentChild, previousChildren) {
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          ...previousChildren,
                          if (currentChild != null) currentChild,
                        ],
                      );
                    },
                    child: showFeedback.value
                        ? Container(
                            key: UniqueKey(), child: _feedbackPage(context))
                        : _regularPage(context)));
              }),
        ),
      )),
    );
  }

  Widget _feedbackPage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Feedback",
            style: TS.h2,
          ),
          // Constants.verticalSpace,
          Text(
            "Leave your feedback below",
            style: TS.h3,
          ),
          Constants.verticalSpace,
          Constants.verticalSpace,
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              maxLines: 5,
              onChanged: (value) {
                controller.feedback = value;
              },
              decoration: const InputDecoration(
                  hintText: "Your feedback here",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10)),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    showFeedback.value = false;
                  },
                  style: BS.defaultBtnStyle,
                  child: const Text("Close")),
              TextButton(
                  onPressed: () async {
                    if (await controller.onSendFeedback()) {
                      showFeedback.value = false;
                    }
                  },
                  style: BS.defaultBtnStyle,
                  child: const Text("Submit")),
            ],
          )
        ],
      ),
    );
  }

  Widget _regularPage(BuildContext context) {
    if (controller.userModel != null) {
      return Container(
        // alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (show)
                Container(
                    height: 55,
                    width: 55,
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: CircleAvatar(
                        radius: 35,
                        child: Obx(() => Image.network(
                            controller.userModel!.value.userImageUrl)),
                      ),
                    )),
              if (show) const SizedBox(height: 5),
              if (show) Text(controller.userModel!.value.email),
              if (show) const SizedBox(height: 15),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     InkWell(
              //       onTap: () {
              //         Get.to(() => WatchingView(), arguments: {
              //           "list": GFI<ProfileState>()?.userModel?.value.watching
              //         });
              //       },
              //       child: AtomBox(
              //         value: GFI<ProfileState>()
              //                 ?.userModel
              //                 ?.value
              //                 .watching
              //                 .length ??
              //             0,
              //         label: "Bookmarks",
              //       ),
              //     ),
              //     GetBuilder<OfferState>(
              //       builder: (__) {
              //         return InkWell(
              //           onTap: () {
              //             Get.to(() => const OffersView());
              //           },
              //           child: AtomBox(
              //             value: __.getIncomingOffersLength(),
              //             label: "Offers",
              //           ),
              //         );
              //       },
              //     ),
              //   ],
              // ),
              ListTile(
                onTap: () {
                  Get.to(() => CarsView());
                },
                title: const Text("Cars"),
                leading: Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Icon(
                    CupertinoIcons.car_detailed,
                    color: toc.textColor,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(() => MessagesView());
                },
                title: const Text("Messages"),
                leading: Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Icon(
                    CupertinoIcons.chat_bubble,
                    color: toc.textColor,
                  ),
                ),
              ),
              ListTile(
                title: const Text("Your Posts"),
                onTap: () {
                  Get.to(() => PersonalPosts());
                },
                leading: Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Icon(
                    CupertinoIcons.rectangle_on_rectangle_angled,
                    color: toc.textColor,
                  ),
                ),
              ),
              ListTile(
                title: const Text("Offers"),
                trailing: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: toc.cardColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      GFI<OfferState>()?.getIncomingOffersLength().toString() ??
                          "",
                      textScaler: const TextScaler.linear(1.3),
                      style: TextStyle(
                          color: toc.textColor, fontWeight: FontWeight.w600),
                    )),
                onTap: () {
                  Get.to(() => const OffersView());
                },
                leading: Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.inbox,
                    color: toc.textColor,
                  ),
                ),
              ),
              ListTile(
                title: const Text("Bookmarks"),
                trailing: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: toc.cardColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      GFI<ProfileState>()
                              ?.userModel
                              ?.value
                              .watching
                              .length
                              .toString() ??
                          "",
                      textScaler: const TextScaler.linear(1.3),
                      style: TextStyle(
                          color: toc.textColor, fontWeight: FontWeight.w600),
                    )),
                onTap: () {
                  Get.to(() => WatchingView(), arguments: {
                    "list": GFI<ProfileState>()?.userModel?.value.watching
                  });
                },
                leading: Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.bookmark,
                    color: toc.textColor,
                  ),
                ),
              ),
              // const Spacer(),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.find<GE>().user_logout();
                      },
                      style: BS.defaultBtnStyle,
                      child: const Text("Log out")),
                  const SizedBox(width: 10),
                  Hero(
                    tag: "feedback",
                    child: TextButton(
                        onPressed: () {
                          showFeedback.value = true;
                        },
                        style: BS.defaultBtnStyle,
                        child: const Text("Feedback")),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const SizedBox(height: 40),
            ]),
      );
    } else {
      // return const Text("Hello world");
      return Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  style: BS.defaultBtnStyle,
                  onPressed: () async {
                    var res = await Get.find<GE>().signInWithGoogle();
                    if (!res) {
                      SBUtil.showErrorSnackBar(
                          "Unable to sign in with google. Please try again later");
                    }
                  },
                  child: const Text("Log in")),
              Hero(
                tag: "feedback",
                child: TextButton(
                    onPressed: () async {
                      showFeedback.value = true;
                    },
                    style: BS.defaultBtnStyle,
                    child: const Text("Feedback")),
              ),
            ],
          ),
          // const SizedBox(height: 40),
        ]),
      );
    }
  }
}
