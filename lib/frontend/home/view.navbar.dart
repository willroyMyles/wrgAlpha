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
      decoration: BoxDecoration(
          color: toc.scaffoldBackgroundColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(0)),
      // height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 0),
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
                width: isSelected ? 50 : 50,
                // height: isSelected ? 50 : 50,
                // padding:
                //     const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 15,
                            offset: const Offset(0, 2))
                    ]),
                child: Icon(
                  e.icon,
                  color: isSelected
                      ? toc.primaryColor.darkerF(20)
                      : toc.textColor.withOpacity(.55),
                  size: isSelected ? 23 : 23,
                  shadows: [
                    if (isSelected)
                      BoxShadow(
                          color: toc.primaryColor.darkerF(30).withOpacity(.35),
                          blurRadius: 10,
                          offset: const Offset(0, 2))
                  ],
                ));

            return AnimatedSize(
              duration: dur,
              child: Container(
                margin: const EdgeInsets.all(5),
                child: GestureDetector(
                    onTap: () {
                      e.onTap();
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          selected,
                          AnimatedContainer(
                            duration: dur,
                            // constraints: BoxConstraints(
                            //   maxWidth: isSelected ? 50 : 0,
                            // ),
                            height: 25,
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  e.title,
                                  style: TS.h4.copyWith(
                                      color: isSelected
                                          ? toc.primaryColor
                                          : toc.textColor.withOpacity(.8),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.5),
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
