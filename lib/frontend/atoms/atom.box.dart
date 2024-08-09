import 'package:flutter/widgets.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.card.dart';

class AtomBox<T extends dynamic> extends StatelessWidget {
  final T? value;
  final String label;
  const AtomBox({super.key, this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return CardWidgetBG(
      constraints: const BoxConstraints(minWidth: 90, maxWidth: 95),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(value.toString()),
          Opacity(
              opacity: Constants.opacity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label.toUpperCase(),
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w700),
                ),
              )),
        ],
      ),
    );
  }
}
