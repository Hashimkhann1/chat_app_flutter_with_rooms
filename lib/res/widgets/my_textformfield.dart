import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final Color? hintColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final BorderSide enabledBorderSide;
  final BorderSide focedBorderSide;
  final IconData? prefixIcon;
  final Color? prefixIcocColor;
  final bool obscureText;
  final TextEditingController? controller;

  const MyTextFormField(
      {super.key,
      required this.hintText,
      this.fontWeight,
      this.fontSize,
      this.hintColor,
      this.enabledBorderSide = const BorderSide(color: Color(0xFFFFFFFF), width: 2.0),
      this.focedBorderSide = const BorderSide(color: Color(0xff9E9E9E), width: 2.0),
      this.prefixIcon,
      this.prefixIcocColor,
      this.obscureText = false,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon,color: prefixIcocColor,),
          hintText: hintText,
          fillColor: Theme.of(context).colorScheme.tertiary,
          filled: true,
          hintStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: hintColor,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: enabledBorderSide
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: focedBorderSide
          )
      ),
    );
  }
}
