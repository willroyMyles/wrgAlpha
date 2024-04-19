import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/atoms/atom.bottomSheet.dart';
import 'package:wrg2/frontend/pages/post/details/state.postDetails.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class PostDetails extends StatelessWidget {
  PostDetails({super.key});
  final controller = Get.put(PostDetailsState());

  @override
  Widget build(BuildContext context) {
    controller.onView();
    return Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => Column(
            children: [
              GetBuilder<PostDetailsState>(
                  init: controller,
                  builder: (_) {
                    return Container(
                      padding: Constants.ePadding,
                      color: Colors.white,
                      child: SafeArea(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(controller.model.title),
                              const Divider(),
                              Text(controller.model.content),
                              const Divider(),
                              Opacity(
                                opacity: Constants.opacity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(controller.model.category),
                                        Text(controller.model.subCategory),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(controller.model.make),
                                        Text(controller.model.model),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    );
                  }),
              if (GF<ProfileState>().isSignedIn.value)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          controller.onWatching();
                        },
                        child: const Text("Watch")),
                    if (!controller.model.amIOwner())
                      TextButton(
                          onPressed: () async {
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
                                        // alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Constants.cardpadding,
                                            vertical:
                                                Constants.cardVerticalMargin),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child:
                                                    buildInput("Offer", (val) {
                                              controller.offerString.value =
                                                  val;
                                            })),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 15),
                                              child: IconButton(
                                                  onPressed: () {
                                                    controller.sendOffers();
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
                          child: const Text("Offer")),
                    TextButton(
                        onPressed: () async {
                          //show bottom sheet with comment input
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
                                      // alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Constants.cardpadding,
                                          vertical:
                                              Constants.cardVerticalMargin),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child:
                                                  buildInput("Comment", (val) {
                                            controller.commentString.value =
                                                val;
                                          })),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 15),
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
                        child: const Text("Comment")),
                  ],
                ),
              const Spacer(),
              const Spacer(),
              GetBuilder<PostDetailsState>(
                init: controller,
                initState: (_) {},
                builder: (_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIconsInfo(
                          CupertinoIcons.eyeglasses, controller.model.watching,
                          () {
                        Get.snackbar("Info",
                            "${controller.model.watching} persons are currently watching this post");
                      }),
                      _buildIconsInfo(
                          CupertinoIcons.eye, controller.model.views, () {
                        Get.snackbar("Info",
                            "${controller.model.views} persons have viewed this post");
                      }),
                      _buildIconsInfo(
                          CupertinoIcons.chat_bubble, controller.model.comments,
                          () async {
                        await showWrgBottomSheet(Container(
                          alignment: Alignment.center,
                          child: FutureBuilder<dynamic>(
                              future: controller.getCommentsForPost(),
                              builder: (context, snapshot) {
                                return Column(
                                  children: [
                                    const Text("Comments"),
                                    const Divider(),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: controller.comments.length,
                                        itemBuilder: (context, index) {
                                          var item = controller.comments[index];
                                          return item.tile();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ));

                        controller.comments = [];
                      }),
                    ],
                  );
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ));
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
