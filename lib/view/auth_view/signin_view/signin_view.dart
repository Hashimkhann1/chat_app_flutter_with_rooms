import 'package:chat_app/res/widgets/my_icon.dart';
import 'package:chat_app/res/widgets/my_text.dart';
import 'package:chat_app/res/widgets/my_text_button.dart';
import 'package:chat_app/res/widgets/my_textformfield.dart';
import 'package:chat_app/view/auth_view/signup_vieew/signup_view.dart';
import 'package:chat_app/view_model/auth_view_model/auth_view_model.dart';
import 'package:chat_app/view_model/getx/loading/loadgin_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  final LoadingGetx loadingGetx = Get.put(LoadingGetx());
  final _formKey = GlobalKey<FormState>();
  final AuthViewModel authViewModel = AuthViewModel();

  final _gmailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        title: MyText(title: "Sign In",),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                MyIcon(
                  icon: Icons.message_outlined,
                  size: 56,
                  color: color.primary,
                ),
                const SizedBox(
                  height: 12,
                ),
                // welcome back message
                MyText(
                  title: "Welcome Back, you've been missed!",
                  color: color.primary,
                  fontSize: 16,
                ),

                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        // eamil textfield
                        MyTextFormField(
                          controller: _gmailController,
                          hintText: "Email",
                          hintColor: color.primary,
                          prefixIcon: Icons.email,
                          prefixIcocColor: color.primary,
                          focedBorderSide:
                              BorderSide(color: Colors.grey.shade500),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Gmail";
                            } else if (!value.contains('@gmail.com')) {
                              return "Enter Valid Gmail";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // password textfield
                        MyTextFormField(
                          controller: _passwordController,
                          hintText: "Password",
                          hintColor: color.primary,
                          prefixIcon: Icons.password,
                          prefixIcocColor: color.primary,
                          obscureText: true,
                          focedBorderSide:
                              BorderSide(color: Colors.grey.shade500),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            }
                          },
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),

                // login button
                Obx((){
                  return MyTextButton(
                    title: "Sign In",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    loading: loadingGetx.isLoading.value,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        authViewModel.signInUser(
                            context,
                            _gmailController.text.toString(),
                            _passwordController.text.toString());
                      }
                    },
                    backgroundColor: color.secondary,
                    height: 44.0,
                  );
                }),
                const SizedBox(
                  height: 16,
                ),

                // rgister now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(title: "Not a member?"),
                    MyTextButton(
                      title: 'Register now',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpView()));
                      },
                      width: 100,
                      textColor: Colors.blue.shade500,
                      fontWeight: FontWeight.bold,
                      height: 24,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
