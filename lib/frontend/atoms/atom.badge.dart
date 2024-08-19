import 'package:flutter/material.dart';

Widget buildBadge(num? count) {
  if (count == null || count == 0) return Container();
  return Container(
    width: 30,
    height: 30,
    alignment: Alignment.center,
    // padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
        color: Colors.white.withOpacity(.85),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(width: 2, color: Colors.red)),
    child: Text(
      count.toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
    ),
  );
}
