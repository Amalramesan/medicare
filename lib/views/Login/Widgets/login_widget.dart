import 'package:flutter/material.dart';
import 'package:med_care/routes/app_routes.dart';
import 'package:med_care/views/Login/Widgets/login_button_widget.dart';
import 'package:med_care/views/Login/Widgets/login_form_widget.dart';
import 'package:med_care/views/Login/Widgets/login_header_widget.dart';
import 'package:med_care/views/Login/Widgets/login_signup_button_widget.dart';

class Logindetails extends StatefulWidget {
  const Logindetails({super.key});

  @override
  State<Logindetails> createState() => _LogindetailsState();
}

class _LogindetailsState extends State<Logindetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  void _handleSignUp() {
    Navigator.pushReplacementNamed(context, AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const LoginHeaderWidget(),
          LoginWidget(formKey: _formKey),
          const SizedBox(height: 20),
          LoginButton(onSignInTap: _handleSignIn),
          const SizedBox(height: 20),
          LoginButtonWidget(onTapp: _handleSignUp),
        ],
      ),
    );
  }
}
