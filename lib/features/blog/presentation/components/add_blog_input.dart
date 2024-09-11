import 'package:flutter/material.dart';

class AddBlogInputComponent extends StatelessWidget {
  const AddBlogInputComponent(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onChanged,
      this.keyBoardType = TextInputType.name});

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyBoardType;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        onChanged: onChanged,
        keyboardType: keyBoardType,
        maxLines: null,
        validator: (value) {
          // value!.isEmpty ? '$hintText is missing' : null;
          if (value == null || value.isEmpty) {
            return '$hintText is missing';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
    );
  }
}
