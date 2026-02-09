import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;
  final Icon icon;
  final bool isObscure;
  final Widget? suffixIcon;

  const FormTextField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.sp),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isObscure,
        textInputAction: TextInputAction.next,
        autocorrect: false,
        enableSuggestions: false,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: icon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
