import 'package:chat_app/res/widgets/my_icon.dart';
import 'package:chat_app/res/widgets/my_text.dart';
import 'package:chat_app/view/setting_view/setting_view.dart';
import 'package:chat_app/view_model/auth_view_model/auth_view_model.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});
  final AuthViewModel authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // logo
              DrawerHeader(
                  child: MyIcon(
                    icon: Icons.message_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 46,
                  )),

              // home list lite
               Padding (
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const MyText(
                    title: "Home",
                  ),
                  leading: const MyIcon(icon: Icons.home,),
                  onTap: (){
                    // navigate to home view
                    Navigator.pop(context);
                  },
                ),
              ),

              // setting list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: MyText(
                    title: "Setting",
                  ),
                  leading: const MyIcon(icon: Icons.settings,),
                  onTap: (){
                    // navigate to Settign view
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettignView() ));
                  },
                ),
              ),
            ],
          ),

          // logout list tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0,bottom: 30),
            child: ListTile(
              title: const MyText(
                title: "Logout",
              ),
              leading: const MyIcon(icon: Icons.logout,),
              onTap: () {
                authViewModel.signOutUser(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
