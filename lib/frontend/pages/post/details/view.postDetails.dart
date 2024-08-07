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
              // TextButton(
              //     onPressed: () async {
              //       Get.close(1);
              //       await Get.bottomSheet(BottomSheet(
              //         onClosing: () {},
              //         builder: (context) {
              //           return Container(
              //             color: toc.scaffoldBackgroundColor,
              //             child: SafeArea(
              //               child: Container(
              //                   decoration: BoxDecoration(
              //                       borderRadius: Constants.br,
              //                       color: toc.scaffoldBackgroundColor),
              //                   // alignment: Alignment.center,
              //                   padding: EdgeInsets.symmetric(
              //                       horizontal: Constants.cardpadding,
              //                       vertical: Constants.cardVerticalMargin),
              //                   child: Row(
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     children: [
              //                       Expanded(
              //                           child: buildInput("Comment", (val) {
              //                         controller.commentString.value = val;
              //                       })),
              //                       Container(
              //                         margin: const EdgeInsets.only(top: 15),
              //                         child: IconButton(
              //                             onPressed: () {
              //                               controller.sendComment();
              //                             },
              //                             icon: const Icon(
              //                               CupertinoIcons
              //                                   .arrow_up_right_circle,
              //                               size: 25,
              //                             )),
              //                       )
              //                     ],
              //                   )),
              //             ),
              //           );
              //         },
              //       ));
              //     },
              //     child: const Text("Add Comment")),
              if (!controller.model.amIOwner() &&
                  GF<ProfileState>().isSignedIn.value)
                TextButton(
                    onPressed: () async {
                      Get.close(1);
                      await Get.bottomSheet(BottomSheet(
                        onClosing: () {},
                        builder: (context) {
                          return OfferBottomComp();
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
                                      vertical: Constants.cardVerticalMargin),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: buildInput("Offer", (val) {
                                        controller.offerString.value = val;
                                      })),
                                      Container(
                                        margin: const EdgeInsets.only(top: 15),
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
                    child: const Row(
                      children: [
                        Text("Make Offer"),
                      ],
                    )),
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
            // TextButton(
            //     onPressed: () {
            //       if (controller.bottomView.value != 1) {
            //         controller.updateBottomView(1);
            //       }
            //     },
            //     child: const Text("View Comments")),
          ],
        )
      ],
      // bottomNavigationBar: SafeArea(
      //   child: GetBuilder<PostDetailsState>(
      //     init: controller,
      //     initState: (_) {},
      //     builder: (_) {
      //       return Container(
      //         decoration: BoxDecoration(
      //           color: toc.scaffoldBackgroundColor,
      //         ),
      //         height: 50,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             _buildIconsInfo(
      //                 CupertinoIcons.eyeglasses, controller.model.watching,
      //                 () {
      //               Get.snackbar("Info",
      //                   "${controller.model.watching} persons are currently watching this post");
      //             }),
      //             _buildIconsInfo(CupertinoIcons.eye, controller.model.views,
      //                 () {
      //               Get.snackbar("Info",
      //                   "${controller.model.views} persons have viewed this post");
      //             }),
      //             _buildIconsInfo(
      //                 CupertinoIcons.chat_bubble, controller.model.comments,
      //                 () async {
      //               await showWrgBottomSheet(Container(
      //                 alignment: Alignment.center,
      //                 child: FutureBuilder<dynamic>(
      //                     future: controller.getCommentsForPost(),
      //                     builder: (context, snapshot) {
      //                       return Column(
      //                         children: [
      //                           const Text("Comments"),
      //                           const Divider(),
      //                           Expanded(
      //                             child: ListView.builder(
      //                               itemCount: controller.comments.length,
      //                               itemBuilder: (context, index) {
      //                                 var item = controller.comments[index];
      //                                 return item.tile();
      //                               },
      //                             ),
      //                           ),
      //                         ],
      //                       );
      //                     }),
      //               ));

      //               controller.comments = [];
      //             }),
      //           ],
      //         ),
      //       );
      //     },
      //   ),
      // ),
      body: Column(
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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // spacing: 10,
                                  // runAlignment: WrapAlignment.center,
                                  children: [
                                    Text("${controller.model.year} "),
                                    Text("${controller.model.make} "),
                                    Text(controller.model.model),
                                  ],
                                ),
                                Text(controller.model.category),
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
          // if (GF<ProfileState>().isSignedIn.value)
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       TextButton(
          //         onPressed: () {
          //           controller.onWatching();
          //         },
          //         child: Obx(() {
          //           var isWatching = GF<ProfileState>()
          //                   .userModel
          //                   ?.value
          //                   .watching
          //                   .contains(controller.model.id) ??
          //               false;
          //           return !isWatching
          //               ? const Text("Bookmark")
          //               : const Text("Bookmarked");
          //         }),
          //       ),
          //       if (!controller.model.amIOwner())
          //         TextButton(
          //             onPressed: () async {
          //               await Get.bottomSheet(BottomSheet(
          //                 onClosing: () {},
          //                 builder: (context) {
          //                   return OfferBottomComp();
          //                 },
          //               ));
          //             },
          //             child: const Text("Offer")),
          //       TextButton(
          //           onPressed: () async {
          //             //show bottom sheet with comment input
          //             await Get.bottomSheet(BottomSheet(
          //               onClosing: () {},
          //               builder: (context) {
          //                 return Container(
          //                   color: toc.scaffoldBackgroundColor,
          //                   child: SafeArea(
          //                     child: Container(
          //                         decoration: BoxDecoration(
          //                             borderRadius: Constants.br,
          //                             color: toc.scaffoldBackgroundColor),
          //                         // alignment: Alignment.center,
          //                         padding: EdgeInsets.symmetric(
          //                             horizontal: Constants.cardpadding,
          //                             vertical:
          //                                 Constants.cardVerticalMargin),
          //                         child: Row(
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.center,
          //                           children: [
          //                             Expanded(
          //                                 child:
          //                                     buildInput("Comment", (val) {
          //                               controller.commentString.value =
          //                                   val;
          //                             })),
          //                             Container(
          //                               margin:
          //                                   const EdgeInsets.only(top: 15),
          //                               child: IconButton(
          //                                   onPressed: () {
          //                                     controller.sendComment();
          //                                   },
          //                                   icon: const Icon(
          //                                     CupertinoIcons
          //                                         .arrow_up_right_circle,
          //                                     size: 25,
          //                                   )),
          //                             )
          //                           ],
          //                         )),
          //                   ),
          //                 );
          //               },
          //             ));
          //           },
          //           child: const Text("Comment")),
          //     ],
          //   ),
          // const Spacer(),
          SizedBox(height: Constants.cardMargin),
          SizedBox(height: Constants.cardMargin),
          SizedBox(height: Constants.cardMargin),
          Expanded(
            child: GetBuilder<PostDetailsState>(
                init: controller,
                builder: (_) {
                  if (controller.bottomView.value == 0) {
                    return AtomFutureBuilder<OfferModel>(
                        title: "Offer",
                        // list: controller.offers,
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
                        // list: controller.comments,
                        title: "Comment",
                        builder: (context, item) {
                          return Container(
                              padding: Constants.ePadding,
                              margin: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.content),
                                  Text(item.username ?? ""),
                                ],
                              ));
                        },
                        onCall: controller.getCommentsForPost());
                  }

                  return Obx(() {
                    if (controller.bottomView.value == 0 &&
                        controller.offers.isEmpty) {
                      return Container(
                        height: 300,
                        alignment: Alignment.center,
                        child: Constants.emptyWidget("No Offers available"),
                      );
                    }
                    if (controller.bottomView.value == 1 &&
                        controller.comments.isEmpty) {
                      return Container(
                        height: 300,
                        alignment: Alignment.center,
                        child: Constants.emptyWidget("No comments"),
                      );
                    }
                    if (controller.bottomView.value == 0) {
                      return Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  "${controller.offers.length} ${controller.offers.length > 1 ? 'Offers' : 'Offer'} Available",
                                  style: TS.h2),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: controller.offers.length,
                                  itemBuilder: (context, index) {
                                    var item =
                                        controller.offers.elementAt(index);
                                    return Container(
                                        padding: Constants.ePadding,
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(item.message),
                                            Text(item.offerPrice ?? ""),
                                          ],
                                        ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  "${controller.comments.length} ${controller.comments.length > 1 ? 'Comments' : 'Comment'} Available",
                                  style: TS.h2),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: controller.comments.length,
                                  itemBuilder: (context, index) {
                                    var item =
                                        controller.comments.elementAt(index);
                                    return Container(
                                        padding: Constants.ePadding,
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(item.content),
                                            Text(item.username ?? ""),
                                          ],
                                        ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  });
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
