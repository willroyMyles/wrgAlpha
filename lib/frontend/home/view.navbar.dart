import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.promptHelper.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
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
  WrgNavBar({
    super.key,
    this.items = const [],
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    var bgc = toc.textColor;
    var fgc = toc.cardColor;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 70,
            margin: const EdgeInsets.only(left: 10, bottom: 20),
            decoration: BoxDecoration(
                color: bgc, borderRadius: BorderRadius.circular(110)),
            // height: 60,
            // margin: const EdgeInsets.symmetric(horizontal: 10),
            clipBehavior: Clip.antiAlias,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: items.map((e) {
                  var isSelected = items.indexOf(e) == selectedIndex;
                  var dur = Constants.fastAnimationSpeed;

                  return AnimatedOpacity(
                    duration: Constants.fastAnimationSpeed,
                    opacity: isSelected ? 1 : .8,
                    child: AnimatedSize(
                      duration: dur,
                      child: AnimatedContainer(
                        alignment: Alignment.center,
                        duration: Constants.fastAnimationSpeed,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: isSelected
                              ? toc.cardColor
                              : toc.cardColor.withOpacity(.0),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
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
                                  color: isSelected ? bgc : fgc,
                                  size: 23,
                                  shadows: [
                                    if (isSelected)
                                      BoxShadow(
                                          color: toc.secondaryHeaderColor
                                              .darkerF(30)
                                              .withOpacity(.35),
                                          blurRadius: 30,
                                          offset: const Offset(0, 2))
                                  ],
                                ),
                                const SizedBox(height: 5),
                                AnimatedContainer(
                                  duration: 150.milliseconds,
                                  width: isSelected ? null : 0,
                                  margin:
                                      EdgeInsets.only(left: isSelected ? 8 : 0),
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        e.title.toUpperCase(),
                                        style: TS.h4.copyWith(
                                            color: bgc,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.5),
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
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30, right: 10, bottom: 23),
          child: InkWell(
            onTap: () {},
            child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: toc.textColor,
                    borderRadius: BorderRadius.circular(110)),
                child: buildPopup(
                    Container(
                        child: Icon(
                      Icons.add,
                      color: toc.cardColor,
                      size: 35,
                    )),
                    [
                      TextButton(
                          onPressed: () async {
                            Get.close(1);
                            if (await guardPrompt()) {
                              Get.to(() => CreatePost());
                            }
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.post_add),
                              SizedBox(width: 5),
                              Text("Request Car Part")
                            ],
                          )),
                      TextButton(
                          onPressed: () async {
                            Get.close(1);
                            if (await guardPrompt()) {
                              Get.to(() => CreatePost(), arguments: {
                                "isService": true,
                              });
                            }
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.room_service_outlined),
                              SizedBox(width: 5),
                              Text("Request Car Service")
                            ],
                          )),
                    ])),
          ),
        )
      ],
    );
  }
}
