import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/enums/enum.post.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/comment.model.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.promptHelper.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/atoms/stom.futureBuilder.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';
import 'package:wrg2/frontend/pages/services/details/state.serviceDetails.dart';

class ServiceDetails extends StatelessWidget {
  ServiceDetails({super.key});
  final controller = Get.put(ServiceDetailsState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: toc.scaffoldBackgroundColor.lighterF(20),
        centerTitle: true,
        title: const Text("Service Details"),
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
          buildPopup(
            const Icon(CupertinoIcons.ellipsis_vertical_circle),
            [
              Obx(() => TextButton(
                  onPressed: () {
                    Get.close(1);
                    controller.onWatching();
                  },
                  child: (GF<ProfileState>()
                              .userModel
                              ?.value
                              .watching
                              .contains(controller.model.id) ??
                          false)
                      ? const Text("Remove Bookmark")
                      : const Text("Add Bookmark"))),
              TextButton(
                  onPressed: () async {
                    Get.close(1);
                    await Get.bottomSheet(BottomSheet(
                      onClosing: () {},
                      builder: (context) {
                        return Container(
                          color: toc.scaffoldBackgroundColor,
                          child: SafeArea(
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: Constants.br,
                                    color: toc.scaffoldBackgroundColor),
                                padding: EdgeInsets.symmetric(
                                    horizontal: Constants.cardpadding,
                                    vertical: Constants.cardVerticalMargin),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: buildInput("Comment", (val) {
                                      controller.commentString.value = val;
                                    })),
                                    Container(
                                      margin: const EdgeInsets.only(top: 15),
                                      child: IconButton(
                                          onPressed: () {
                                            controller.sendComment();
                                          },
                                          icon: const Icon(
                                            CupertinoIcons
                                                .arrow_up_right_circle,
                                            size: 25,
                                          )),
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                    ));
                  },
                  child: const Text("Add Comment")),
              if (controller.model.amIOwner())
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
                onPressed: () {
                  if (controller.bottomView.value != 0) {
                    controller.updateBottomView(0);
                  }
                },
                child: const Text("View Offers")),
            TextButton(
                onPressed: () {
                  if (controller.bottomView.value != 1) {
                    controller.updateBottomView(1);
                  }
                },
                child: const Text("View Comments")),
          ],
        )
      ],
      body: Column(
        children: [
          GetBuilder<ServiceDetailsState>(
              init: controller,
              builder: (_) {
                return Hero(
                  tag: controller.model.id,
                  child: Material(
                    child: Container(
                      padding: Constants.ePadding,
                      color: toc.scaffoldBackgroundColor.lighterF(20),
                      child: SafeArea(
                        child: SingleChildScrollView(
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
                                  children: [
                                    Text("${controller.model.year} "),
                                    Text("${controller.model.make} "),
                                    Text(controller.model.model),
                                  ],
                                ),
                                Text(controller.model.category ?? "other"),
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
                  ),
                );
              }),
          SizedBox(height: Constants.cardMargin),
          SizedBox(height: Constants.cardMargin),
          SizedBox(height: Constants.cardMargin),
          Expanded(
            child: GetBuilder<ServiceDetailsState>(
                init: controller,
                builder: (_) {
                  if (controller.bottomView.value == 0) {
                    return AtomFutureBuilder<OfferModel>(
                        title: "Offer",
                        builder: (context, item) {
                          return Container(
                              padding: Constants.ePadding,
                              margin: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.message),
                                  Text(item.offerPrice ?? ""),
                                ],
                              ));
                        },
                        onCall: controller.getOffers());
                  } else {
                    return AtomFutureBuilder<CommentModel>(
                        title: "Comment",
                        builder: (context, item) {
                          return Container(
                              padding: Constants.ePadding,
                              margin: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.content ?? ""),
                                  Text(item.username ?? ""),
                                ],
                              ));
                        },
                        onCall: controller.getCommentsForPost());
                  }
                }),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
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
