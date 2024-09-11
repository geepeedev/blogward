// import 'package:blog_ward/features/authentication/presentation/components/authfield_validators.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.hintText,
    required this.prefixicon,
    required this.controller,
    this.isObscureText = false,
    this.keyboardType,
    this.errorsMap,
    this.textChange,
  });

  final String hintText;
  final IconData prefixicon;
  final TextEditingController controller;
  final bool isObscureText;
  final TextInputType? keyboardType;
  final Map<String, bool>? errorsMap;
  final void Function(String)? textChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        onChanged: textChange,
        textInputAction: TextInputAction.done,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: isObscureText,
        decoration: InputDecoration(
          labelText: hintText,
          // constraints: const BoxConstraints.expand(width: 300, height: 300),

          prefixIcon: Icon(
            prefixicon,
          ),
        ),
      ),
    );
  }
}
