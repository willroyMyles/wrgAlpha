import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/widget.extension.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class WatchingAtom extends StatelessWidget {
  const WatchingAtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      // width: Get.width / 2.6,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GetBuilder<ProfileState>(
            initState: (_) {},
            builder: (_) {
              var watch = _.userModel?.value.watching.length ?? 0;
              return Text("$watch");
            },
          ),
          const Opacity(opacity: Constants.opacity, child: Text("Watching")),
        ],
      ),
    ).card;
  }
}
