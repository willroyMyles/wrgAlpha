import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/widget.extension.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/pages/post/details/view.postDetails.dart';

class PostItem extends StatelessWidget {
  final PostModel model;
  const PostItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Get.to(() => PostDetails(), arguments: {"id": model.id}, opaque: false);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Constants.cardMargin,
          vertical: Constants.cardVerticalMargin,
        ),
        padding: Constants.ePadding,
        decoration: (card as Container).decoration,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Txt(model.title.capitalizeFirst!).h2,
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
        ]),
      ),
    );
  }
}
