import 'package:chat_app/res/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  const ChatBubble({super.key,required this.isSender,required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
        // alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 6),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSender ? Colors.green : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(12)
        ),
        child: MyText(title: message,color: Colors.white,)
    );
  }
}
