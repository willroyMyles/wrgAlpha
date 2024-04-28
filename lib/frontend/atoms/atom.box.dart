import 'package:flutter/widgets.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

class AtomBox extends StatelessWidget {
  final dynamic value;
  final String label;
  const AtomBox({super.key, this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      padding: EdgeInsets.all(Constants.cardpadding),
      decoration: BoxDecoration(
        color: toc.scaffoldBackgroundColor.darkerF(20),
        borderRadius: Constants.br,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(value.toString()),
          Opacity(
              opacity: Constants.opacity,
              child: Text(
                label.toUpperCase(),
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              )),
        ],
      ),
    );
  }
}
