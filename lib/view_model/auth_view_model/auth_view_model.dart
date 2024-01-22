import 'package:chat_app/res/utils/utils.dart';
import 'package:chat_app/view/auth_view/signin_view/signin_view.dart';
import 'package:chat_app/view/home_view/home_view.dart';
import 'package:chat_app/view_model/getx/loading/loadgin_getx.dart';
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
      }).onError((error, stackTrace) {
        Utils().toastMessage("User not Loged In, Try again!");
        print("Error from singUpUser while loging user ${error.toString()}");
        loadingGetx.setLoading();
      });

    } catch (e) {
      Utils().toastMessage("User not Loged In, Try again!");
      loadingGetx.setLoading();
      print("Error from singInUser while loging user ${e.toString()}");
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
            Utils().toastMessage("User SignIn Successfully");
            loadingGetx.setLoading();
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
      })
          .onError((error, stackTrace) {
            loadingGetx.setLoading();
            Utils().toastMessage("User not SignUp, Try again!");
            print("Error from singUpUser while regestring user ${error.toString()}");
      });
    } catch (e) {
      Utils().toastMessage("User not SignUp, Try again!");
      loadingGetx.setLoading();
      print("Error from singUpUser while regestring user ${e.toString()}");
    }
  }

  // sign out method

  signOutUser(BuildContext context) async {
    try{
      await _auth.signOut().then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInView()));
        Utils().toastMessage("User Sign out");
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
