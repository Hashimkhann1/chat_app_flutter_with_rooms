import 'package:chat_app/res/widgets/chat_bubble.dart';
import 'package:chat_app/res/widgets/my_text.dart';
import 'package:chat_app/view_model/auth_view_model/auth_view_model.dart';
import 'package:chat_app/view_model/chat_view_model/chat_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatView({super.key,required this.receiverEmail,required this.receiverID});

  // text controller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth services
  final ChatViewModel chatViewModel = ChatViewModel();
  final AuthViewModel authViewModel = AuthViewModel();
  final _auth = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(title: "Chat",),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            const SizedBox(height: 16,),
            // getting all messages
            Expanded(
                child: StreamBuilder(
                  stream: chatViewModel.getMessages(_auth.uid, receiverID),
                  builder: (context , snapshot) {
                    if(snapshot.hasError){
                      return MyText(title: "Error");
                    }
                    else if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView(
                      children: snapshot.data!.docs.map((doc) {
                        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                        // checking sender messages
                        bool isSender = data['senderID'].toString() == _auth.uid.toString();
                        return Column(
                          crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            ChatBubble(isSender: isSender, message: data['message']),
                          ],
                        );
                      }).toList(),
                    );
                  },
                )
            ),

            // textfield and send message button
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // textfield
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Type Your Message",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)
                        )
                      ),
                    ),
                  ),

                  // icon button
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle
                    ),
                    child: IconButton(onPressed: (){
                      if(_messageController.text.isNotEmpty){
                        chatViewModel.sendMessage(receiverID, _messageController.text.toString());
                        _messageController.clear();
                      }
                    }, icon: Icon(Icons.arrow_upward,size: 30,color: Colors.white,)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
