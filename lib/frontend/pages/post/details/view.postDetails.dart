import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/atoms/atom.bottomSheet.dart';
import 'package:wrg2/frontend/pages/post/details/atom.offerBottomComp.dart';
import 'package:wrg2/frontend/pages/post/details/state.postDetails.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class PostDetails extends StatelessWidget {
  PostDetails({super.key});
  final controller = Get.put(PostDetailsState());

  @override
  Widget build(BuildContext context) {
    // controller.onView();
    return Scaffold(
        appBar:
            AppBar(backgroundColor: toc.scaffoldBackgroundColor.lighterF(20)),
        body: Obx(
          () => Column(
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // spacing: 10,
                                      // runAlignment: WrapAlignment.center,
                                      children: [
                                        _buildLabel("Year",
                                            controller.model.year.toString()),
                                        _buildLabel(
                                            "make", controller.model.make),
                                        _buildLabel(
                                            "model", controller.model.model),
                                        _buildLabel("category",
                                            controller.model.category),
                                        _buildLabel("sub-category",
                                            controller.model.subCategory),
                                      ],
                                    )
                                  ]),
                            ),
                          ),
                        ),
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
                      child: Obx(() {
                        var isWatching = GF<ProfileState>()
                                .userModel
                                ?.value
                                .watching
                                .contains(controller.model.id) ??
                            false;
                        return !isWatching
                            ? const Text("Watch")
                            : const Text("Watching");
                      }),
                    ),
                    if (!controller.model.amIOwner())
                      TextButton(
                          onPressed: () async {
                            await Get.bottomSheet(BottomSheet(
                              onClosing: () {},
                              builder: (context) {
                                return OfferBottomComp();
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

  Widget _buildLabel(String label, String value) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Opacity(opacity: .5, child: Text("${label.capitalize!}: ")),
          Text(value),
        ],
      ),
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
