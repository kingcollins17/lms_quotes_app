import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:lms_quotes_app/screens.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth;

  User? get user => _auth.currentUser;

  final bool inTestMode;

  final isLoading = false.obs;

  final isAuthenticated = false.obs;

  final Rx<String?> notification = 'Welcome, '.obs;

  AuthController({FirebaseAuth? auth, this.inTestMode = false})
      : this._auth = auth ?? FirebaseAuth.instance;

  void notify(String value) {
    notification.value = value;
    Get.snackbar(
      'Notification',
      notification.value!,
      duration: Duration(seconds: 6),
    );
  }

  void clearNotification() => notification.value = null;

  Future<void> createUser({required String email, required String password}) async {
    try {
      isLoading.value = true;
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      isLoading.value = false;
      isAuthenticated.value = true;

      /// if not in test mode
      if (!inTestMode) {
        Get.off(QuotesListScreen());
        Get.snackbar(
          'Sign up successful',
          'You are successfully signed up as $email',
          duration: const Duration(seconds: 7),
        );
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (!inTestMode) Get.snackbar('Sign up not successful', e.toString());
    }
  }

  Future<void> loginUser({required String email, required String password}) async {
    try {
      isLoading.value = true;
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading.value = false;
      isAuthenticated.value = true;
      if (!inTestMode) {
        Get.off(QuotesListScreen());
        Get.snackbar('Message', 'Welcome, you are now signed in as ${user?.email ?? ""}');
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (!inTestMode) { //if not in test mode
        Get.snackbar(
          'Something went wrong',
          '$e\nPlease check that your email or password is correct',
          duration: const Duration(seconds: 7),
        );
      }
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    _auth.signOut();
    isLoading.value = false;
  }
}
