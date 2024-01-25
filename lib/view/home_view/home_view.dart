import 'package:chat_app/res/widgets/my_drawer.dart';
import 'package:chat_app/res/widgets/my_icon.dart';
import 'package:chat_app/res/widgets/my_text.dart';
import 'package:chat_app/view/chat_view/chat_view.dart';
import 'package:chat_app/view_model/auth_view_model/auth_view_model.dart';
import 'package:chat_app/view_model/chat_view_model/chat_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final ChatViewModel _chatViewModel = ChatViewModel();
  final AuthViewModel _authViewModel = AuthViewModel();
  final _logedinUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          title: "Home",
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: StreamBuilder(
        stream: _chatViewModel.getUserStream(),
        builder: (context, snapshot) {
          // error
          if (snapshot.hasError) {
            return const Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // loading..

          // return list view
          return ListView(
            children: snapshot.data!.map<Widget>((userData) {
              return _logedinUser.email == userData['userEmail']
                  ? SizedBox()
                  : InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatView(
                                      receiverEmail:
                                          userData['userEmail'].toString(),
                                  receiverID: userData['userUid'],
                                    )));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            const MyIcon(icon: Icons.person,size: 30,),
                            const SizedBox(
                              width: 14,
                            ),
                            MyText(
                              title: userData['userName'],
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                            )
                          ],
                        ),
                      ),
                    );
            }).toList(),
          );
        },
      ),
    );
  }
}
