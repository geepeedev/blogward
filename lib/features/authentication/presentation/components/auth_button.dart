import 'package:blog_ward/core/theme/app_sizes.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.buttonText, this.buttonAction});
  final String buttonText;
  final void Function()? buttonAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonBorderRadius),
          ),
        ),
        onPressed: buttonAction,
        child:  Text(buttonText),
      ),
    );
  }
}
