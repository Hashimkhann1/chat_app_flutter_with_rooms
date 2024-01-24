import 'package:chat_app/res/utils/utils.dart';
import 'package:chat_app/view/auth_view/signin_view/signin_view.dart';
import 'package:chat_app/view/home_view/home_view.dart';
import 'package:chat_app/view_model/getx/loading/loadgin_getx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthViewModel {
  final _auth = FirebaseAuth.instance;
  final Utils utils = Utils();
  final LoadingGetx loadingGetx = Get.put(LoadingGetx());

  // sign method
  void signInUser(BuildContext context, String gmail, String passsword) async {
    loadingGetx.setLoading();
    try {
      await _auth.signInWithEmailAndPassword(email: gmail, password: passsword).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
        toastMessage("User Logedin Successfully");
        loadingGetx.setLoading();
      });

    } on FirebaseAuthException catch (e) {
      loadingGetx.setLoading();
      toastMessage(e.code.toString());

    }
  }

  // signUp method
  void signUpUser(BuildContext context, String gmail, String passsword) async {
    loadingGetx.setLoading();
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: gmail.toString(), password: passsword.toString())
          .then((value) {
            toastMessage("User SignIn Successfully");
            loadingGetx.setLoading();
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
      })
          .onError((error, stackTrace) {
            loadingGetx.setLoading();
            toastMessage("User not SignUp, Try again!");
            print("Error from singUpUser while regestring user ${error.toString()}");
      });

      // ading user info
      if(_auth.currentUser != null){
        await FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).set({
          "userName": gmail.split('@')[0],
          'userEmail': gmail.toString(),
          'userUid': _auth.currentUser!.uid.toString(),
          'dateAndTime': DateTime.now(),
        }).onError((error, stackTrace){
          print(">>>>>>> Error from adding user info after authentication");
          print(error.toString());
        });
      }
    } catch (e) {
      toastMessage("User not SignUp, Try again!");
      loadingGetx.setLoading();
      print("Error from singUpUser whi12345678le regestring user ${e.toString()}");
    }
  }


  // sign out method
  signOutUser(BuildContext context) async {
    try{
      await _auth.signOut().then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInView()));
        toastMessage("User Sign out");
      }).onError((error, stackTrace) {
        print(error.toString()+"from signout on error message");
      });
    }catch(e){
      print(e.toString()+"error form signout user");
    }
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white
    );
  }
}
