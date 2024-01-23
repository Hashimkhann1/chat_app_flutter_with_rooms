import 'package:chat_app/res/widgets/my_text.dart';
import 'package:flutter/material.dart';

class SettignView extends StatelessWidget {
  const SettignView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(title: "Setting"),
      ),
      body: Column(),
    );
  }
}
