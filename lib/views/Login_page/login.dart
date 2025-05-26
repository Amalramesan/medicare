import 'package:flutter/material.dart';
import 'package:med_care/routes/app_routes.dart';
import 'login_widget.dart'; // import the widget file

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signinUser() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  void signup() {
    Navigator.pushReplacementNamed(context, AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginWidget(
        formKey: _formKey,
        emailController: emailController,
        passwordController: passwordController,
        onSignInTap: signinUser,
        onSignUpTap: signup,
      ),
    );
  }
}
