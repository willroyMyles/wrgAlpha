import 'package:flutter/material.dart';

enum Status {
  OPEN("Open", Colors.green),
  PROCESSING("Processing", Colors.blue),
  COMPLETED("Completed", Colors.purple),
  EXPIRED("Expired", Colors.red),
  CANCELED("Canceled", Colors.orange);

  final String displayName;
  final Color color;

  const Status(this.displayName, this.color);
}

extension StatusHelper on Status {
  static Color openColor = Colors.green;
  static Color allColor = Colors.white;
  static Color processingColor = Colors.blue;
  static Color completedColor = Colors.purple;
  static Color expiredColor = Colors.red;
  static Color cancelledColor = Colors.orange;

  Color getColor() {
    // if (this == Status.ALL) return StatusHelper.allColor;
    if (this == Status.OPEN) return StatusHelper.openColor;
    if (this == Status.PROCESSING) return StatusHelper.processingColor;
    if (this == Status.COMPLETED) return StatusHelper.completedColor;
    if (this == Status.EXPIRED) return StatusHelper.expiredColor;
    if (this == Status.CANCELED) return StatusHelper.cancelledColor;
    return Colors.transparent;
  }

  Widget get textName => Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
            // color: this.getColor().lighter().withOpacity(.5),
            border: Border(
          right: BorderSide(
            color: getColor(),
            width: 6,
          ),
          // left: BorderSide(color: this.getColor(), width: 0),
          // top: BorderSide(color: this.getColor(), width: 0),
          // bottom: BorderSide(color: this.getColor(), width: 0),
        )),
        child: Text(name,
            style: TextStyle(
              color: getColor(),
              fontWeight: FontWeight.w700,
              fontSize: 20,
            )),
      );

  String get name => toString().toLowerCase().replaceAll("status.", "");
}
