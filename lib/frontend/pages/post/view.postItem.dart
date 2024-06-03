import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/widget.extension.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
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
              buildChip(model.status.name, color: model.status.color),
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
                    // Text(model.subCategory),
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

          Obx(() {
            var state = GF<ProfileState>();
            if (state.isSignedIn.value == false) {
              return Container();
            }
            return Opacity(
              opacity: .7,
              child: Row(
                children: [
                  (state.userModel?.value.watching.contains(model.id) ?? false)
                      ? Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: buildChip("Watching", color: toc.textColor))
                      : Container(),
                  if (state.userModel?.value.email == model.userEmail)
                    buildChip("Owner", color: toc.textColor)
                ],
              ),
            );
          }),
        ]),
      ),
    );
  }
}
