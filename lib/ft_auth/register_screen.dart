import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_quotes_app/constants.dart';
import 'package:lms_quotes_app/controllers/controller.dart';
import 'package:lms_quotes_app/screens.dart';

import 'widgets/widgets.dart';

class RegisterScreen extends GetWidget<AuthController> {
  const RegisterScreen({super.key});

  void onSubmit(String email, String password) {
    controller.createUser(
      email: email,
      password: password,
    ).catchError((err) => Get.snackbar('Error', err.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: heather,
      body: SizedBox(
        height: screen(context).height,
        width: screen(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthForm(
              type: 'register',
              loginScreen: LoginScreen(),
              onSubmit: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
