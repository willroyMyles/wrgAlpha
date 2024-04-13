import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildInput(String label, onChange,
    {bool obscure = false,
    FormFieldValidator? validator,
    int? lines,
    double height = 80,
    TextEditingController? tec,
    String? initialValue}) {
  return Container(
    height: height,
    decoration: const BoxDecoration(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3, bottom: 05),
          child: Text(
            label.capitalize!,
            style: const TextStyle(color: Colors.grey),
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
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                // labelText: this.labelText,
                focusedBorder: border,
                enabledBorder: border,
                border: border),
          ),
        ),
      ],
    ),
  );
}

InputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.white));
