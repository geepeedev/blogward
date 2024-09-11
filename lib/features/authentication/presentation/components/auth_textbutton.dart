import 'package:blog_ward/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthTextButton extends StatelessWidget {
  const AuthTextButton({super.key, required this.buttonText, this.onPressed});

  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.bold, color: AppPallete.secondaryColor),
      ),
    );
  }
}
