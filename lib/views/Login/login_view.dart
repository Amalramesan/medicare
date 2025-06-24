
import 'package:flutter/material.dart';
import 'package:med_care/views/Login/Widgets/login_button_wrapper.dart';
import 'package:med_care/views/Login/Widgets/login_form_wrapper.dart';
import 'package:med_care/views/Login/Widgets/login_header_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LoginHeaderWidget(), //this is the header
            LoginFormWrapper(   // it is for texteform field
              formKey: formKey,
              emailController: emailController,
              passwordController: passwordController,
            ),
            const SizedBox(height: 20),
            LoginButtonWrapper(  //this is for button
              formKey: formKey,
              emailController: emailController,
              passwordController: passwordController,
            ),
          ],
        ),
      ),
    );
  }
}
