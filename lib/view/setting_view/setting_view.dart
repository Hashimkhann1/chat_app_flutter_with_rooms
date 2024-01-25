import 'package:chat_app/res/dark_light_mode/dark_mode.dart';
import 'package:chat_app/res/widgets/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettignView extends StatefulWidget {
  const SettignView({super.key});

  @override
  State<SettignView> createState() => _SettignViewState();
}

class _SettignViewState extends State<SettignView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(title: "Setting"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(title: "Dark Mode",fontWeight: FontWeight.bold,fontSize: 18,),
            CupertinoSwitch(value: false
                , onChanged: (value){},)
          ],
        ),
      ),
    );
  }
}
