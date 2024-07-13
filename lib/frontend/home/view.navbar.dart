import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

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
    return Container(
      decoration: BoxDecoration(
          color: toc.textColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(50)),
      // height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.map((e) {
            var isSelected = items.indexOf(e) == selectedIndex;
            var dur = Constants.fastAnimationSpeed;
            // var unSelected = Container(
            //     // constraints: const BoxConstraints(maxWidth: 50, maxHeight: 50),
            //     padding: const EdgeInsets.all(15),
            //     decoration: BoxDecoration(
            //         color: Colors.white, borderRadius: BorderRadius.circular(50)),
            //     child: Icon(
            //       e.icon,
            //       size: 22,
            //     ));
            var selected = Container(
                key: UniqueKey(),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: !isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  e.icon,
                  color: isSelected
                      ? toc.textColor.withOpacity(.8)
                      : toc.textColor.withOpacity(.55),
                  size: isSelected ? 23 : 22,
                ));
            return AnimatedSize(
              duration: dur,
              child: Container(
                margin: const EdgeInsets.all(8),
                child: GestureDetector(
                    onTap: () {
                      e.onTap();
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedSwitcher(duration: dur, child: selected),
                          AnimatedContainer(
                            duration: dur,
                            constraints: BoxConstraints(
                              maxWidth: isSelected ? 70 : 0,
                            ),
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  e.title,
                                  style: TS.h4.copyWith(
                                      color: toc.textColor.withOpacity(.8),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                )),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
