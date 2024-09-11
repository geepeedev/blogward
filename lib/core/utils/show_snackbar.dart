import 'package:blog_ward/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        // shape: const CircleBorder(eccentricity: 0.2),
        backgroundColor: AppPallete.primaryColor,
        duration: const Duration(milliseconds: 2000),
        content: Text(
          content,
          style: const TextStyle(color: AppPallete.whiteColor),
        ),
      ),
    );
}
