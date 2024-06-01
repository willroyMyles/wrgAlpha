import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/extension/widget.extension.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/post/details/view.postDetails.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class PostItem extends StatelessWidget {
  final PostModel model;
  const PostItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Get.to(() => PostDetails(), arguments: {"post": model}, opaque: false);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Constants.cardMargin,
          vertical: Constants.cardVerticalMargin,
        ),
        padding: Constants.ePadding,
        decoration: (card as Container).decoration,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Expanded(child: Txt(model.title.capitalizeFirst!).h2),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: model.status.color.withOpacity(.15),
                    border: Border.all(
                        color: model.status.color.withOpacity(.6), width: .6),
                    borderRadius: Constants.br,
                  ),
                  child: Text(
                    model.status.name,
                    style: TextStyle(
                        color: model.status.color.darker, fontSize: 12),
                  )),
            ],
          ),
          Txt(
            model.content,
            maxLines: 1,
          ).h4,
          // const Divider(),
          Opacity(
            opacity: Constants.opacity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.category),
                    Text(model.subCategory),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(model.make),
                    Text(model.model),
                  ],
                ),
              ],
            ),
          ),

          Obx(() => (GF<ProfileState>()
                      .userModel
                      ?.value
                      .watching
                      .contains(model.id) ??
                  false)
              ? Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Icon(
                    CupertinoIcons.eyeglasses,
                    color: toc.primaryColor.darker,
                  ))
              : Container()),
        ]),
      ),
    );
  }
}
