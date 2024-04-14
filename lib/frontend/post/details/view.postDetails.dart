import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/post/details/state.postDetails.dart';

class PostDetails extends StatelessWidget {
  PostDetails({super.key});
  final controller = Get.put(PostDetailsState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.model.category),
                                    Text(controller.model.subCategory),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    controller.onWatching();
                  },
                  child: const Text("Watch")),
              TextButton(onPressed: () {}, child: const Text("Offer")),
              TextButton(onPressed: () {}, child: const Text("Comment")),
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
                  _buildIconsInfo(CupertinoIcons.eyeglasses,
                      controller.model.watching, () {}),
                  _buildIconsInfo(
                      CupertinoIcons.eye, controller.model.views, () {}),
                  _buildIconsInfo(CupertinoIcons.chat_bubble,
                      controller.model.offers.length, () {}),
                ],
              );
            },
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildIconsInfo(IconData ic, int number, Null Function() param2) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(children: [
        Text(number.toString()),
        Icon(
          ic,
          size: 30,
        ),
      ]),
    );
  }
}
