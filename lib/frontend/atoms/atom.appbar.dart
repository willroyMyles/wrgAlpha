import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

class WRGAppBar extends StatelessWidget {
  final String label;
  final String? additional;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  const WRGAppBar(this.label,
      {super.key, this.additional, this.bottom, this.actions});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      backgroundColor: toc.scaffoldBackgroundColor.withOpacity(.1),
      titleSpacing: 0,
      centerTitle: false,
      scrolledUnderElevation: 30,
      elevation: 0,
      shadowColor: toc.scaffoldBackgroundColor.withOpacity(.1),
      actions: actions,
      // bottom: bottom,
      // toolbarHeight: 50,
      // collapsedHeight: 50,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: toc.primaryColor,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            // padding: EdgeInsets.only(left: offset!, top: 5),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: toc.cStyle.copyWith(fontSize: 20),
                    ),
                  ),
                ),
                if (additional != null)
                  Opacity(
                    opacity: .7,
                    child: Text(
                      additional!,
                      style: toc.cStyle
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  )
                else
                  const SizedBox(
                    height: 10,
                  ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
        expandedTitleScale: 1.5,
      ),
      stretch: false,
      pinned: true,
    );
  }
}
