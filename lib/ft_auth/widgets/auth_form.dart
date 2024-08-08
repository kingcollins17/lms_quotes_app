import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_quotes_app/constants.dart';
import 'package:lms_quotes_app/controllers/controller.dart';

typedef OnSubmitAuthForm = void Function(String email, String password);

class AuthForm extends StatefulWidget {
  AuthForm({
    super.key,
    this.type = 'register',
    required this.onSubmit,
    this.registerScreen,
    this.loginScreen,
  }) : assert(['register', 'login'].contains(type), 'type $type is not allowed');
  final String type;

  final OnSubmitAuthForm onSubmit;

  final Widget? registerScreen, loginScreen;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String? email, password;
  final formKey = GlobalKey<FormState>();

  bool _obscurePassword = false;
  bool get obscurePassword => _obscurePassword;

  set obscurePassword(bool value) => setState(() => _obscurePassword = value);

  @override
  Widget build(BuildContext context) {
    const noAccount = 'Don\'t have an account? Register';
    const hasAccount = 'Already have an account? Login';

    final isLogin = widget.type == 'login';

    const loadingIndicator = SizedBox.square(
      dimension: 23.0,
      child: CircularProgressIndicator(
        color: Colors.white,
        backgroundColor: Colors.transparent,
        strokeWidth: 2.5,
      ),
    );

    final controller = Get.find<AuthController>();
    return Container(
      width: screen(context).width * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                isLogin ? 'Login' : 'Register',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              spacer(y: 60),
              _InputField(label: 'Email', onChanged: (value) => email=value),
              spacer(y: 15),
              _InputField(
                label: 'Password',
                obscureText: obscurePassword,
                onChanged: (value) => password = value,
                suffixIcon: GestureDetector(
                  onTap: () => obscurePassword = !_obscurePassword,
                  child: Icon(
                    obscurePassword ? Icons.visibility_sharp : Icons.visibility_off,
                    size: 18,
                  ),
                ),
              ),
              spacer(y: 30),
              FilledButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      widget.onSubmit(email!, password!);
                    }
                  },
                  style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size(screen(context).width, 45.0)),
                  ),
                  child: Obx(() {
                    final isLoading = controller.isLoading.value;
                    return isLoading
                        ? loadingIndicator
                        : Text(
                            isLogin ? 'Login' : 'Register',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                  })),
              spacer(y: 15),
              GestureDetector(
                onTap: () {
                  if (isLogin && widget.registerScreen != null) {
                    Get.off(widget.registerScreen);
                  } else if (!isLogin && widget.loginScreen != null) {
                    Get.off(widget.loginScreen);
                  }
                },
                child: Text(
                  isLogin ? noAccount : hasAccount,
                  style: const TextStyle(fontSize: 16, color: cerulean),
                ),
              )
            ],
          )),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.label,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
  });
  final String label;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onChanged: onChanged,
      validator: (value) => value == null || value.isEmpty ? '$label field is required' : null,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: (suffixIcon != null)
            ? Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: suffixIcon)
            : null,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      ),
    );
  }
}
