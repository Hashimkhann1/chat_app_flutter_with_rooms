import 'package:chat_app/res/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(title: "Chat",),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
