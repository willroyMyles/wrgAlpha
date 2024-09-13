import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

typedef BottomSheetBuilder = Widget Function(
    BuildContext context, ScrollController scrollController);

class BottomSheetComponent extends StatelessWidget {
  final String? title;

  final BottomSheetBuilder builder;
  final double? maxChildSize;
  final double? initialChildSize;
  const BottomSheetComponent(
      {super.key,
      this.title,
      required this.builder,
      this.maxChildSize,
      this.initialChildSize});

  @override
  Widget build(BuildContext context) {
    var childSize = maxChildSize ?? 1.0;
    return DraggableScrollableSheet(
      maxChildSize: childSize,
      minChildSize: (childSize * .5),
      initialChildSize: min(initialChildSize ?? childSize, childSize),
      expand: false,
      // expand: true,

      builder: (context, scrollController) {
        return Column(
          children: [
            if (title != null)
              Container(
                  alignment: Alignment.centerLeft,
                  color: toc.scaffoldBackgroundColor,
                  padding: EdgeInsets.all(Constants.cardpadding),
                  child: Opacity(
                      opacity: .8,
                      child: Text(
                        title ?? "",
                        style: TS.h1,
                      ))),
            Expanded(child: builder(context, scrollController)),
          ],
        );
      },
    );
  }
}
