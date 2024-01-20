import 'package:flutter/material.dart';

class MyIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;
  const MyIcon({super.key,required this.icon,this.color,this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(icon,color: color,size: size,);
  }
}
