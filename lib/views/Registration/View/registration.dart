import 'package:flutter/material.dart';
import 'package:med_care/routes/app_routes.dart';
import 'package:med_care/views/Registration/Widgets/registration_widget.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController ageconteroller = TextEditingController();

  final TextEditingController placecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _handleSignup(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupForm(
        formKey: _formKey,
        nameController: nameController,
        emailController: emailController,
        phoneController: phoneController,
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
        placecontroller: placecontroller,
        agecontroller: ageconteroller,
        onSignupTap: () => _handleSignup(context),
      ),
    );
  }
}
