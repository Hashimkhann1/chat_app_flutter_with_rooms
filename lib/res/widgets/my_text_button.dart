import 'package:chat_app/res/widgets/my_text.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final bool loading;
  final double? width;
  final double? height;
  final void Function()? onTap;

  const MyTextButton({
    super.key,
    required this.title,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.backgroundColor,
    required this.onTap,
    this.width = double.infinity,
    this.height = 40.0,
  this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8)
        ),
        child: loading ? CircularProgressIndicator(color: Colors.black54,) : MyText(title: title,fontSize: fontSize,fontWeight: fontWeight,color: textColor,),
      ),
    );
  }
}
