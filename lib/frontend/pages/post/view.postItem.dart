import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.card.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/post/details/view.postDetails.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class PostItem extends StatelessWidget {
  final PostModel model;
  const PostItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    // return Text(model.title.capitalizeFirst!);
    return Container(
      child: InkWell(
        onTap: () async {
          Get.to(() => PostDetails(),
              arguments: {"post": model}, opaque: false);
        },
        child: CardWidget(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Opacity(
                  opacity: .75,
                  child: Text(
                    model.title.capitalizeFirst!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TS.h3,
                  ),
                )),
                buildChip(model.status.name, color: model.status.color),
              ],
            ),
            Txt(
              model.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TS.h2,
            ),
            // const Divider(),
            Opacity(
              opacity: Constants.opacity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${model.year} "),
                  Text("${model.make} "),
                  Text(model.model),
                  const Spacer(),
                  Expanded(
                    child: Text(
                      model.category,
                      maxLines: 2,
                    ),
                  )
                ],
              ),
            ),
            Constants.verticalSpace,

            Obx(() {
              var state = GF<ProfileState>();
              if (state.isSignedIn.value == false) {
                return Container();
              }
              return Opacity(
                opacity: .7,
                child: Row(
                  children: [
                    (state.userModel?.value.watching.contains(model.id) ??
                            false)
                        ? Container(
                            margin: const EdgeInsets.only(right: 5),
                            child:
                                buildChip("Bookmarked", color: toc.textColor))
                        : Container(),
                    if (state.userModel?.value.email == model.userEmail)
                      buildChip("Owner", color: toc.textColor)
                  ],
                ),
              );
            }),
          ]),
        ),
      ),
    );
  }
}
