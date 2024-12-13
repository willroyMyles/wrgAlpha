import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.promptHelper.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/post/view.createPost.dart';

class WrgNavBarItem {
  final String title;
  final IconData icon;
  final Function onTap;
  WrgNavBarItem({required this.title, required this.icon, required this.onTap});
}

class WrgNavBar extends StatelessWidget {
  List<WrgNavBarItem> items;
  int selectedIndex;
  RxInt selectedRxIndex = 0.obs;
  RxBool isOpen = false.obs;
  WrgNavBar({
    super.key,
    this.items = const [],
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,

          margin: const EdgeInsets.only(left: 10, bottom: 20),
          decoration: BoxDecoration(
            color: toc.textColor,
            borderRadius: BorderRadius.circular(110),
          ),
          // height: 60,
          // margin: const EdgeInsets.symmetric(horizontal: 10),
          clipBehavior: Clip.antiAlias,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: items.map((e) {
              var isSelected = items.indexOf(e) == selectedIndex;
              var dur = Constants.defaultAnimationSpeed;

              return AnimatedOpacity(
                duration: dur,
                opacity: 1,
                child: AnimatedSize(
                  duration: dur,
                  child: AnimatedContainer(
                    alignment: Alignment.center,
                    duration: dur,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: isSelected
                          ? toc.scaffoldBackgroundColor
                          : toc.cardColor.withOpacity(.0),
                    ),
                    margin: isSelected
                        ? const EdgeInsets.symmetric(vertical: 5, horizontal: 5)
                        : EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          e.onTap();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              e.icon,
                              color: isSelected
                                  ? toc.textColor
                                  : toc.scaffoldBackgroundColor,
                              size: 23,

                              // weight: 1,
                              shadows: [
                                if (isSelected)
                                  BoxShadow(
                                      color: toc.scaffoldBackgroundColor
                                          .darkerF(30)
                                          .withOpacity(.35),
                                      blurRadius: 30,
                                      offset: const Offset(0, 2))
                                else
                                  Shadow(
                                      color: toc.scaffoldBackgroundColor
                                          .withOpacity(.0),
                                      blurRadius: 1,
                                      offset: const Offset(0, 0))
                              ],
                            ),
                            const SizedBox(width: 5),
                            AnimatedContainer(
                              duration: 150.milliseconds,
                              width: isSelected ? null : 0,
                              margin: EdgeInsets.only(left: isSelected ? 8 : 0),
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    e.title.toUpperCase(),
                                    textScaler: TextScaler.linear(.9),
                                    style: TS.h4.copyWith(
                                      color: toc.textColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Spacer(),
        Container(
          margin: const EdgeInsets.only(left: 30, right: 10, bottom: 23),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 60,
              width: 60,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(110)),
              child: SpeedDial(
                backgroundColor: toc.textColor,
                foregroundColor: toc.scaffoldBackgroundColor,
                overlayColor: toc.scaffoldBackgroundColor,
                overlayOpacity: 1,
                icon: Icons.add,
                activeIcon: Icons.close,
                elevation: 0,
                spaceBetweenChildren: 0,
                buttonSize: const Size(60, 60),
                childrenButtonSize: const Size(75, 80),
                onOpen: () {
                  isOpen.value = true;
                },
                onClose: () {
                  isOpen.value = false;
                },
                children: <SpeedDialChild>[
                  _createChild(() async {
                    if (await guardPrompt()) {
                      Get.to(() => CreatePost(), arguments: {
                        "isService": true,
                      });
                    }
                  }, Icons.room_service, "Request vehicle service"),
                  _createChild(() async {
                    if (await guardPrompt()) {
                      Get.to(() => CreatePost());
                    }
                  }, Icons.post_add_rounded, "Request vehicle Part"),

                  //  Your other SpeedDialChildren go here.
                ],
                child: const Icon(Icons.add),
              ),
            ),
          ),
        )
      ],
    );
  }

  SpeedDialChild _createChild(Function onTap, IconData icon, String text,
      [bool isFirst = false]) {
    return SpeedDialChild(
      foregroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        height: 60,
        width: 60,
        margin: EdgeInsets.only(bottom: isFirst ? 8 : 0),
        decoration: BoxDecoration(
            color: toc.textColor, borderRadius: BorderRadius.circular(100)),
        child: Icon(
          icon,
          color: toc.scaffoldBackgroundColor,
        ),
      ),
      labelWidget: Container(
        // height: 45,
        margin: const EdgeInsets.only(bottom: 0, right: 0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: toc.textColor, borderRadius: BorderRadius.circular(100)),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Text(
              text,
              style: TS.h3.copyWith(color: toc.cardColor),
            )
          ],
        ),
      ),
      onTap: () async {
        await onTap();
      },
    );
  }
}
