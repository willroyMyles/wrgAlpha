import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/service/service.storage.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.btns.dart';
import 'package:wrg2/backend/utils/util.snackbars.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/cars/view.cars.dart';
import 'package:wrg2/frontend/home/view.home.dart';
import 'package:wrg2/frontend/pages/offers/state.offers.dart';
import 'package:wrg2/frontend/pages/offers/view.offers.dart';
import 'package:wrg2/frontend/pages/personal/view.personalPosts.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';
import 'package:wrg2/frontend/pages/profile/view.editProfile.dart';
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
          appBar: AppBar(
            actions: [
              Obx(() => controller.isSignedIn.value
                  ? TextButton(
                      onPressed: () {
                        Get.to(() => EditProfile());
                      },
                      child: const Text("Edit Profile"))
                  : Container())
            ],
          ),
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

  Widget _buildTile(
      Function onPressed, IconData icon, String title, bool showChev,
      [Widget? append]) {
    return ListTile(
      title: Text(title, style: TS.h3),
      minLeadingWidth: 50,
      leading: Icon(
        icon,
        size: 30,
      ),
      onTap: () {
        onPressed();
      },
      trailing: showChev
          ? const Icon(
              Icons.chevron_right,
              size: 32,
            )
          : append,
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
            style: TS.h1,
          ),
          // Constants.verticalSpace,
          Text(
            "Leave your feedback below for us!",
            style: TS.h3,
          ),
          Constants.verticalSpace,
          Constants.verticalSpace,
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: toc.cardColor, borderRadius: BorderRadius.circular(10)),
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
                  style: BS.secondaryBtnStyle,
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

  RxString theme = "Light".obs;

  Widget _themeChanger() {
    if (theme.value.isEmpty) {
      theme.value = Storage.read("themeMode", null) ?? "Light";
    }
    return Container(
      // margin: EdgeInsets.only(top: 10, bottom: 10)
      child: _buildTile(
          () {},
          Icons.format_paint_outlined,
          "Theme",
          false,
          SizedBox(
            width: Get.width * .5,
            child: Obx(() {
              return buildDropdownOnly((v) async {
                tw.changeTheme(v);

                theme.value = v;
                Storage.write("themeMode", v);
                await Future.delayed(Duration(milliseconds: 300));
                // WidgetsBinding.instance.addPostFrameCallback((v) {
                GF<HomeViewController>().currentIndex.refresh();
                // });
              },
                  ThemeMode.values
                      .map((e) => e.toString().split(".")[1].capitalize!)
                      .toList(),
                  theme.value);
            }),
          )),
    );
  }

  Widget _regularPage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (controller.userModel != null)
              Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              child: Obx(() => Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.transparent),
                                    child: Image.network(
                                      controller.userModel!.value.userImageUrl,
                                      cacheHeight: 80,
                                      cacheWidth: 80,
                                    ),
                                  )),
                            ),
                            if (controller.userModel != null)
                              Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    controller.userModel!.value.username ?? "",
                                    style: TS.h0,
                                  )),
                            if (controller.userModel != null)
                              Opacity(
                                opacity: .7,
                                child: Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                      controller.userModel!.value.email ?? "",
                                      style: TS.h3,
                                    )),
                              ),
                          ],
                        ),
                      )),
                  _buildTile(() {
                    Get.to(() => CarsView());
                  }, CupertinoIcons.car_detailed, "Cars", true),
                  // _buildTile(() {
                  //   Get.to(() => MessagesView());
                  // }, CupertinoIcons.chat_bubble_2, "Messages", true),
                  _buildTile(() {
                    Get.to(() => PersonalPosts());
                  }, CupertinoIcons.rectangle_on_rectangle_angled, "Your Posts",
                      true),
                  _buildTile(() {
                    Get.to(() => const OffersView());
                  },
                      CupertinoIcons.rectangle_on_rectangle_angled,
                      "Offers",
                      false,
                      Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: toc.cardColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            GFI<OfferState>()
                                    ?.getIncomingOffersLength()
                                    .toString() ??
                                "",
                            textScaler: const TextScaler.linear(1.3),
                            style: TextStyle(
                                color: toc.textColor,
                                fontWeight: FontWeight.w600),
                          ))),

                  _buildTile(
                    () {
                      Get.to(() => WatchingView(), arguments: {
                        // "list": GFI<ProfileState>()?.userModel?.value.watching
                      });
                    },
                    CupertinoIcons.bookmark,
                    "Bookmarks",
                    false,
                    Container(
                        margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: toc.cardColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Obx(() => Text(
                              GFI<ProfileState>()
                                      ?.userModel
                                      ?.value
                                      .watching
                                      .length
                                      .toString() ??
                                  "",
                              textScaler: const TextScaler.linear(1.3),
                              style: TextStyle(
                                  color: toc.textColor,
                                  fontWeight: FontWeight.w600),
                            ))),
                  ),

                  _buildTile(() {
                    showFeedback.value = true;
                  }, Icons.subdirectory_arrow_left, "Feedback", true),
                  _themeChanger(),

                  _buildTile(() {
                    GF<GE>().user_logout();
                  }, Icons.exit_to_app, "Log Out", false),
                ],
              )
            else
              Container(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _themeChanger(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              style: BS.defaultBtnStyle,
                              onPressed: () async {
                                var res =
                                    await Get.find<GE>().signInWithGoogle();
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
              )
          ]),
    );
  }
}
