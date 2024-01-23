import 'package:chat_app/res/widgets/my_drawer.dart';
import 'package:chat_app/res/widgets/my_text.dart';
import 'package:chat_app/view_model/auth_view_model/auth_view_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final AuthViewModel authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: MyText(title: "Home",),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Column(),
    );
  }
}
