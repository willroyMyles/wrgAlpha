import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
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
      height: 100,
      decoration: BoxDecoration(
          color: toc.cardColor.withOpacity(.9),
          borderRadius: BorderRadius.circular(0)),
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
                child: Container(
                  margin: const EdgeInsets.all(5),
                  height: 60,
                  width: 60,
                  child: GestureDetector(
                      onTap: () {
                        e.onTap();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            e.icon,
                            color: isSelected
                                ? toc.primaryColor.darkerF(20)
                                : toc.textColor.withOpacity(.55),
                            size: isSelected ? 23 : 23,
                            shadows: [
                              if (isSelected)
                                BoxShadow(
                                    color: toc.primaryColor
                                        .darkerF(30)
                                        .withOpacity(.35),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2))
                            ],
                          ),
                          const SizedBox(height: 5),
                          FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                e.title.toUpperCase(),
                                style: TS.h4.copyWith(
                                    color: isSelected
                                        ? toc.primaryColor
                                        : toc.textColor.withOpacity(.7),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.5),
                              )),
                        ],
                      )),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
