import 'package:chat_app/res/widgets/my_icon.dart';
import 'package:chat_app/res/widgets/my_text.dart';
import 'package:chat_app/res/widgets/my_text_button.dart';
import 'package:chat_app/res/widgets/my_textformfield.dart';
import 'package:chat_app/view_model/auth_view_model/auth_view_model.dart';
import 'package:chat_app/view_model/getx/loading/loadgin_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  ValueNotifier<bool> _toggle = ValueNotifier<bool>(true);

  final LoadingGetx loadingGetx = Get.put(LoadingGetx());
  final AuthViewModel authViewModel = AuthViewModel();
  final _formKey = GlobalKey<FormState>();

  final _gmailController = TextEditingController();
  final _passwrodController = TextEditingController();
  final _confirmPasswrodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        title: MyText(title: "Register",),
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
                  title: "Let's create an account for you",
                  color: color.primary,
                  fontSize: 15,
                ),

                ValueListenableBuilder(
                    valueListenable: _toggle,
                    builder: (context , value , child) {
                      return Form(
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
                                focedBorderSide: BorderSide(
                                  color: Colors.grey.shade500,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Gmail";
                                  } else if (!value.contains("@gmail.com")) {
                                    return "Enter Valid Gmail";
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // password textfield
                              MyTextFormField(
                                controller: _passwrodController,
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
                                  } else if (value.length <= 7) {
                                    return "Password must be grater than 7 characters";
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              // confirm password
                              MyTextFormField(
                                controller: _confirmPasswrodController,
                                hintText: "Confirm Password",
                                hintColor: color.primary,
                                prefixIcon: Icons.password,
                                prefixIcocColor: color.primary,
                                obscureText: true,
                                focedBorderSide:
                                BorderSide(color: Colors.grey.shade500),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Password";
                                  } else if (value.length <= 7) {
                                    return "Password must be grater than 7 characters";
                                  } else if (_passwrodController.text !=
                                      value.toString()) {
                                    return "Confirm Password not matched";
                                  }
                                },
                              ),
                            ],
                          ));
                    }
                ),
                const SizedBox(
                  height: 20,
                ),

                // login button
                Obx(() {
                  return MyTextButton(
                    title: "Register",
                    loading: loadingGetx.isLoading.value,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        authViewModel.signUpUser(context, _gmailController.text,
                            _passwrodController.text);
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
                    MyText(title: "Already have an Account!"),
                    MyTextButton(
                      title: 'Login now',
                      onTap: () {
                        Navigator.pop(context);
                      },
                      width: 72,
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
