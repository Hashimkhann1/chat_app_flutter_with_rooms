import 'package:chat_app/res/widgets/chat_bubble.dart';
import 'package:chat_app/res/widgets/my_text.dart';
import 'package:chat_app/view_model/auth_view_model/auth_view_model.dart';
import 'package:chat_app/view_model/chat_view_model/chat_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  ChatView({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // textfield focus
  FocusNode myFocusNode = FocusNode();

  //chat & auth services
  final ChatViewModel chatViewModel = ChatViewModel();
  final AuthViewModel authViewModel = AuthViewModel();
  final _auth = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });

    Future.delayed(const Duration(milliseconds: 400),() => scrollDown());

  }



  @override
  void dispose() {
    // TODO: implement dispose
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // scrool controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(
          title: "Chat",
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            // getting all messages
            Expanded(
                child: StreamBuilder(
              stream: chatViewModel.getMessages(_auth.uid, widget.receiverID),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return MyText(title: "Error");
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  controller: _scrollController,
                  children: snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data =
                        doc.data() as Map<String, dynamic>;
                    // checking sender messages
                    bool isSender =
                        data['senderID'].toString() == _auth.uid.toString();
                    return Column(
                      crossAxisAlignment: isSender
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        ChatBubble(
                            isSender: isSender, message: data['message']),
                      ],
                    );
                  }).toList(),
                );
              },
            )),

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
                      focusNode: myFocusNode,
                      decoration: InputDecoration(
                          hintText: "Type Your Message",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary))),
                    ),
                  ),

                  // icon button
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    child: IconButton(
                        onPressed: () {
                          if (_messageController.text.isNotEmpty) {
                            chatViewModel.sendMessage(widget.receiverID,
                                _messageController.text.toString());
                            _messageController.clear();
                            print("Scrolling down...");
                            scrollDown();
                          }
                          // scrollDown();
                        },
                        icon: Icon(
                          Icons.arrow_upward,
                          size: 30,
                          color: Colors.white,
                        )),
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
