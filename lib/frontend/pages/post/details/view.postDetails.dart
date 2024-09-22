import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/enums/enum.post.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/store/store.logos.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.btns.dart';
import 'package:wrg2/backend/utils/util.promptHelper.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/post/details/atom.offerBottomComp.dart';
import 'package:wrg2/frontend/pages/post/details/atom.offerItem.dart';
import 'package:wrg2/frontend/pages/post/details/state.postDetails.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class PostDetails extends StatelessWidget {
  PostDetails({super.key});
  final controller = Get.put(PostDetailsState());

  @override
  Widget build(BuildContext context) {
    // controller.onView();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: toc.scaffoldBackgroundColor.lighterF(20),
        centerTitle: true,
        // title: const Text("Post Details"),
        leadingWidth: 70,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Row(
            children: [
              Icon(CupertinoIcons.back),
              SizedBox(width: 5),
              Text("Back")
            ],
          ),
        ),
        actions: [
          if (controller.model.amIOwner())
            buildPopup(
              const Icon(CupertinoIcons.ellipsis_vertical_circle),
              [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      color: Colors.black.withOpacity(.1),
                    ),
                    buildPopup(
                        Container(
                          margin: const EdgeInsets.only(
                              left: 10, top: 5, bottom: 5),
                          child: Text(
                            "Update Progress",
                            style: TextStyle(
                                color: toc.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Opacity(
                                  opacity: Constants.opacity,
                                  child: Text("Update Progress", style: TS.h3)),
                            ],
                          ),
                          const Divider(),
                          ...Status.values.map((e) => InkWell(
                                onTap: () {
                                  controller.updateStatus(e);
                                  Get.close(2);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    e.name.capitalize!,
                                    style: TextStyle(
                                      color: e.color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )),
                        ]),
                    TextButton(
                        onPressed: () async {
                          var res = await showBinaryPrompt(
                              "Are you sure you want to delete this post?");
                          if (res) {
                            controller.deletePost();
                          }
                          Get.close(1);
                        },
                        child: const Text(
                          "Delete Post",
                          style: TextStyle(color: Colors.red),
                        )),
                  ],
                ),
              ],
            ),
          const SizedBox(width: 20),
        ],
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                style: BS.plainBtnStyle,
                onPressed: () async {
                  // Get.close(1);
                  if (await guardPrompt()) {
                    controller.onWatching();
                  }
                },
                child: Obx(() => Text(controller.postBookmarked.value
                    ? "Undo Bookmark"
                    : "Boormark"))),
            if (!controller.model.amIOwner() &&
                GF<ProfileState>().isSignedIn.value)
              TextButton(
                  style: BS.defaultBtnStyle,
                  onPressed: () async {
                    await Get.bottomSheet(BottomSheet(
                      onClosing: () {},
                      builder: (context) {
                        return OfferBottomComp();
                      },
                    ));
                  },
                  child: const Text("Make Offer")),
          ],
        )
      ],
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<PostDetailsState>(
                init: controller,
                builder: (_) {
                  // var child = movementUtil.lookUp(controller.model.id);
                  // if (child != null) {
                  //   return Hero(
                  //     tag: controller.model.id,
                  //     child: child,
                  //   );
                  // }

                  var logo = logoHelper.getThumbnail(controller.model.make);
                  return Hero(
                    tag: controller.model.id,
                    child: Material(
                      child: Container(
                        padding: Constants.ePadding,
                        color: toc.scaffoldBackgroundColor.lighterF(20),
                        child: SafeArea(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Txt(controller.model.title).h4,
                                Divider(
                                  color: Colors.black.withOpacity(.1),
                                  indent: 0,
                                  endIndent: 0,
                                ),
                                Txt(controller.model.content).h3,
                                Divider(
                                  color: Colors.black.withOpacity(.1),
                                  indent: 0,
                                  endIndent: 0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // spacing: 10,
                                  // runAlignment: WrapAlignment.center,
                                  children: [
                                    if (logo != null)
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 15),
                                        child: Builder(
                                          builder: (context) {
                                            return Image.network(
                                              logo,
                                              width: 50,
                                              height: 30,
                                              fit: BoxFit.contain,
                                            );
                                          },
                                        ),
                                      ),
                                    Text("${controller.model.year} "),
                                    Text("${controller.model.make} "),
                                    Text(controller.model.model),
                                    const Spacer(),
                                    Text(controller.model.category),
                                  ],
                                ),
                                SizedBox(height: Constants.cardMargin),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "Viewd ${controller.model.views} times",
                                        style: TS.h6),
                                    const Spacer(),
                                    buildChip(controller.model.status.name,
                                        color: controller.model.status.color),
                                  ],
                                )
                              ]),
                        ),
                      ),
                    ),
                  );
                }),
            SizedBox(height: Constants.cardMargin),
            SizedBox(height: Constants.cardMargin),
            SizedBox(height: Constants.cardMargin),
            Obx(() => _buildOfferSection()),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferSection() {
    return Container(
        padding: Constants.ePadding,
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
            // border: Border.all(
            //   width: 3,
            //   color: toc.scaffoldBackgroundColor.darkerF(20),
            // ),
            // // borderRadius: Constants.br * 3,
            // color: toc.scaffoldBackgroundColor.darkerF(20),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                    opacity: .6,
                    child: Text(
                      "${controller.offers.length} Offers",
                      style: TS.h3,
                    )),
                const Spacer(),
                if (controller.offers.length > 3)
                  TextButton(
                      onPressed: () {}, child: const Text("View all offers"))
              ],
            ),
            const SizedBox(height: 5),
            ...controller.offers.take(3).map((e) => OfferItemAtom(
                  model: e,
                )),
          ],
        ));
  }

  Widget _buildLabel(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Opacity(opacity: .5, child: Text("${label.capitalize!} ")),
        Text(value),
      ],
    );
  }

  Widget _buildIconsInfo(IconData ic, int number, FutureOr Function() param2) {
    return InkWell(
      onTap: () {
        param2();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [
          Text(number.toString()),
          Icon(
            ic,
            size: 30,
          ),
        ]),
      ),
    );
  }
}
