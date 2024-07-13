import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/widget.extension.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/service.model.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';
import 'package:wrg2/frontend/pages/services/details/view.serviceDetails.dart';

class ServiceTile extends StatelessWidget {
  final ServiceModel model;
  const ServiceTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Constants.cardMargin,
        vertical: Constants.cardVerticalMargin,
      ),
      child: InkWell(
        onTap: () async {
          // Get.to(() => PostDetails(), arguments: {"post": model}, opaque: false);
          Get.to(() => ServiceDetails(), arguments: {"service": model});
        },
        child: Container(
          padding: Constants.ePadding,
          decoration: decoration,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  model.title.capitalizeFirst!,
                  style: TS.h3,
                )),
                buildChip(model.status.name, color: model.status.color),
              ],
            ),
            Txt(
              model.content,
              maxLines: 1,
              style: TS.h2,
            ),
            // const Divider(),
            Opacity(
              opacity: Constants.opacity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("${model.year} "),
                  Text("${model.make} "),
                  Text(model.model),
                ],
              ),
            ),
            Opacity(
              opacity: Constants.opacity,
              child: Text(model.category ?? "other"),
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
