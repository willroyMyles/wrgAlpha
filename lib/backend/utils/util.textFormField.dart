import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

Widget buildDropdownInput(String label, onChange,
    {bool obscure = false,
    List<String> items = const [],
    FormFieldValidator? validator,
    int? lines,
    double height = 80,
    TextEditingController? tec,
    bool showHelper = true,
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
            child: DropdownButtonFormField<String>(
          value: initialValue,
          onChanged: (String? value) {
            onChange(value);
          },
          menuMaxHeight: Get.height * 0.5,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value.trim(),
              child: Text(value),
            );
          }).toList(),
          isExpanded: true,
          elevation: 30,
          isDense: true,
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

InputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.white));
