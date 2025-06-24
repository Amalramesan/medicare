
import 'package:flutter/material.dart';
import 'package:med_care/views/Login/Widgets/login_form_widget.dart';

class LoginFormWrapper extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormWrapper({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return LoginWidget(
      formKey: formKey,
      emailController: emailController,
      passwordController: passwordController,
    );
  }
}
