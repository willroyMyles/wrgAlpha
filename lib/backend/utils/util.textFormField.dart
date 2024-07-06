import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

Widget buildLargeInput(String label, onChange,
    {bool obscure = false,
    FormFieldValidator? validator,
    int? lines,
    double height = 80,
    TextEditingController? tec,
    bool showHelper = true,
    bool requireInput = false,
    String? initialValue}) {
  return buildInput(label, onChange,
      obscure: obscure,
      validator: validator,
      lines: lines,
      height: height,
      tec: tec,
      showHelper: showHelper,
      largeInput: true,
      requireInput: requireInput,
      initialValue: initialValue);
}

Widget buildInput(String label, onChange,
    {bool obscure = false,
    FormFieldValidator? validator,
    int? lines,
    double height = 80,
    TextEditingController? tec,
    bool showHelper = true,
    bool largeInput = false,
    bool requireInput = false,
    String? initialValue}) {
  return Container(
    height: height,
    decoration: const BoxDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHelper)
          Padding(
            padding: const EdgeInsets.only(left: 3, bottom: 05),
            child: Row(
              children: [
                Text(
                  label.capitalize!,
                  style: const TextStyle(color: Colors.grey),
                ),
                if (requireInput)
                  Text(
                    "*".capitalize!,
                    style: TextStyle(
                        color: Colors.red.withOpacity(0.5),
                        fontWeight: FontWeight.w700),
                  ),
              ],
            ),
          ),
        Expanded(
          child: TextFormField(
            controller: tec,
            validator: validator,
            minLines: lines,
            maxLines: lines,
            expands: lines == null,
            onChanged: onChange,
            initialValue: initialValue,
            textAlign: TextAlign.justify,
            textAlignVertical:
                largeInput ? TextAlignVertical.top : TextAlignVertical.center,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                alignLabelWithHint: true,
                // labelText: label,
                focusedBorder: border,
                enabledBorder: border,
                border: border),
          ),
        ),
      ],
    ),
  );
}

Widget buildInputHorizontal(String label, onChange,
    {bool obscure = false,
    FormFieldValidator? validator,
    int? lines,
    double height = 50,
    TextEditingController? tec,
    bool showHelper = true,
    bool largeInput = false,
    bool requireInput = false,
    String? initialValue}) {
  return Container(
    height: height,
    decoration: const BoxDecoration(),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showHelper)
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 3, bottom: 05),
              child: Row(
                children: [
                  Text(
                    label.capitalize!,
                    style: TextStyle(
                        color: toc.textColor.withOpacity(.8),
                        fontWeight: FontWeight.w600),
                  ),
                  if (requireInput)
                    Text(
                      "*".capitalize!,
                      style: TextStyle(
                          color: Colors.red.withOpacity(0.5),
                          fontWeight: FontWeight.w700),
                    ),
                ],
              ),
            ),
          ),
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: tec,
            validator: validator,
            minLines: lines,
            maxLines: lines,
            expands: lines == null,
            onChanged: onChange,
            initialValue: initialValue,
            textAlign: TextAlign.justify,
            textAlignVertical:
                largeInput ? TextAlignVertical.top : TextAlignVertical.center,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                alignLabelWithHint: true,
                // labelText: label,
                focusedBorder: border,
                enabledBorder: border,
                border: border),
          ),
        ),
      ],
    ),
  );
}

Widget buildDropdownInput(String label, onChange,
    {List<String> items = const [],
    double height = 80,
    bool showHelper = true,
    bool requireInput = false,
    bool dense = false,
    String? initialValue}) {
  return Container(
    height: height,
    decoration: const BoxDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHelper)
          Padding(
            padding: const EdgeInsets.only(left: 3, bottom: 05),
            child: Row(
              children: [
                Text(
                  label.capitalize!,
                  style: const TextStyle(color: Colors.grey),
                ),
                if (requireInput)
                  Text(
                    "*".capitalize!,
                    style: TextStyle(
                        color: Colors.red.withOpacity(0.5),
                        fontWeight: FontWeight.w700),
                  ),
              ],
            ),
          ),
        Expanded(
            child: DropdownButtonFormField<String>(
          value: initialValue,
          onChanged: (String? value) {
            onChange(value);
          },
          menuMaxHeight: Get.height * 0.5,
          items: items.map((String value) {
            var isFirst = value == items.first;
            var isLast = value == items.last;
            return DropdownMenuItem<String>(
              value: value.trim(),
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Text(value)),
            );
          }).toList(),
          isExpanded: true,
          elevation: 30,
          dropdownColor: toc.cardColor,
          isDense: dense,
          enableFeedback: true,
          padding: const EdgeInsets.all(0),
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.only(left: 8, top: 2),

              // labelText: this.labelText,
              focusedBorder: border,
              enabledBorder: border,
              border: border),
        )),
      ],
    ),
  );
}

Widget buildDropdownInputHorizontal(String label, onChange,
    {List<String> items = const [],
    double height = 60,
    bool showHelper = true,
    bool requireInput = false,
    bool dense = false,
    String? additional,
    String? initialValue}) {
  return Container(
    height: height,
    decoration: const BoxDecoration(),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showHelper)
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 3, bottom: 05),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "${label.capitalize!} : ",
                            maxLines: 1,
                            style: TextStyle(
                                color: toc.textColor.withOpacity(.8),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        if (additional != null)
                          Text(
                            additional,
                            maxLines: 2,
                            style: TextStyle(
                                color: toc.textColor.withOpacity(.7),
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                          )
                      ],
                    ),
                  ),
                  if (requireInput)
                    Text(
                      "*".capitalize!,
                      style: TextStyle(
                          color: Colors.red.withOpacity(0.5),
                          fontWeight: FontWeight.w700),
                    ),
                ],
              ),
            ),
          ),
        Expanded(
            flex: 2,
            child: DropdownButtonFormField<String>(
              value: initialValue,
              onChanged: (String? value) {
                onChange(value);
              },
              menuMaxHeight: Get.height * 0.5,
              items: items.map((String value) {
                var isFirst = value == items.first;
                var isLast = value == items.last;
                return DropdownMenuItem<String>(
                  value: value.trim(),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(value)),
                );
              }).toList(),
              isExpanded: true,
              elevation: 30,
              dropdownColor: toc.cardColor,
              isDense: dense,
              enableFeedback: true,
              padding: const EdgeInsets.all(0),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 8, top: 2),

                  // labelText: this.labelText,
                  focusedBorder: border,
                  enabledBorder: border,
                  border: border),
            )),
      ],
    ),
  );
}

Widget buildChip(String text, {Color color = Colors.transparent}) {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(.15),
        border: Border.all(color: color.withOpacity(.6), width: .6),
        borderRadius: Constants.br,
      ),
      child: Text(
        text,
        style: TextStyle(color: color.darker, fontSize: 12),
      ));
}

Widget buildPopup(Widget child, List<Widget> children) {
  return CustomPopup(
      contentPadding: EdgeInsets.zero,
      contentRadius: 5,
      showArrow: false,
      content: Container(
        width: Get.width * .5,
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
      child: child);
}

InputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.white));
