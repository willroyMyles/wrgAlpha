import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension TFF on TextFormField {
  Widget input({String label = "", int? minLines, double? height}) {
    // ServiceTheme ts = Get.find<ServiceTheme>();
    var bc = Colors.grey;
    var lineHeight = 0.0;
    var tff = this;

    InputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white));

    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 3, bottom: 05),
            child: Text(
              label.capitalize!,
              textScaleFactor: .9,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: Colors.grey.withOpacity(.1),
                    offset: const Offset(0, 10))
              ],
            ),
            child: TextFormField(
              validator: validator,
              controller: controller,
              minLines: minLines,
              maxLines: minLines,
              expands: minLines == null,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  // labelText: this.labelText,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: bc,
                    width: lineHeight,
                  )),
                  enabledBorder: border,
                  border: border),
            ),
          ),
          // BottomLine()
        ],
      ),
    );
  }
}
