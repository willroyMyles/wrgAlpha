import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/post/details/view.postDetails.dart';

class PostItem extends StatelessWidget {
  final PostModel model;
  const PostItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => PostDetails(), arguments: {"id": model.id});
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: Constants.ePadding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: Constants.br,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(model.title),
          Text(
            model.content,
            maxLines: 1,
          ),
          const Divider(),
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
