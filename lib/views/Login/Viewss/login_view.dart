import 'package:flutter/material.dart';
import 'package:med_care/routes/app_routes.dart';
import '../Widgets/login_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void signinUser(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  void signup(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginWidget(
        formKey: _formKey,
        emailController: emailController,
        passwordController: passwordController,
        onSignInTap: () => signinUser(context),
        onSignUpTap: () => signup(context),
      ),
    );
  }
}
