
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_quotes_app/constants.dart';
import 'package:lms_quotes_app/controllers/controller.dart';
import 'package:lms_quotes_app/screens.dart';

import 'widgets/widgets.dart';

class LoginScreen extends GetWidget<AuthController> {
  const LoginScreen({super.key});

  Future<void> onSubmit(String email, String password) async {
    controller
        .loginUser(
          email: email,
          password: password,
        )
        .catchError((err) => Get.snackbar(
              'error',
              err.toString(),
            ));
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
              type: 'login',
              registerScreen: const RegisterScreen(),
              onSubmit: onSubmit,
            )
          ],
        ),
      ),
    );
  }
}
