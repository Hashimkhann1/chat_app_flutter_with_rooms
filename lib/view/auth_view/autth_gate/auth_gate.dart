import 'package:chat_app/view/auth_view/signin_view/signin_view.dart';
import 'package:chat_app/view/home_view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context , snapshot) {

          // user is logedin
          if(snapshot.hasData){
            print('user is logedin');

            return HomeView();
          }

          // user is not logedin
          else{
            print('user is not logedin');
            return SignInView();
    }
        },
      ),
    );
  }
}
