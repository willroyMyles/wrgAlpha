import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/messages.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

class MessageItem extends StatelessWidget {
  final MessagesModel item;
  const MessageItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Constants.cardMargin,
        vertical: Constants.cardVerticalMargin / 4,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            item.amISender() ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: toc.scaffoldBackgroundColor
                          .darkerF(50)
                          .withOpacity(.3),
                      blurRadius: 5,
                    )
                  ],
                  color: item.amISender()
                      ? toc.scaffoldBackgroundColor.darker
                      : toc.scaffoldBackgroundColor.lighterF(10)),
              child: Txt(item.content.capitalizeFirst!).h4),
        ],
      ),
    );
  }
}
