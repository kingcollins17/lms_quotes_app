import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:lms_quotes_app/constants.dart';
import 'package:lms_quotes_app/controllers/controller.dart';

import 'package:lms_quotes_app/screens.dart';

import 'firebase_options.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(QuotesApp());
  } catch (e) {
    runApp(ShowError(error: e));
  }
}

class QuotesApp extends StatelessWidget {
  const QuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => QuotesController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: cerulean,
          secondary: heather,
        ),
      ),
      home: LoginScreen(),
    );
  }
}

class ShowError extends StatelessWidget {
  const ShowError({super.key, this.error});
  final dynamic error;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Text(error.toString(),
            style: const TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
            ))
      ],
    ));
  }
}
