import 'package:flutter/material.dart';
import 'package:med_care/routes/app_routes.dart';
import 'package:med_care/utilities/cliper.dart';
import 'package:med_care/views/Regerstration/regerstration_widget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      // Do signup logic here, then navigate
      Navigator.pushNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 300),
                  painter: RPSCustomPainter(),
                ),
                Positioned(
                  top: 16,
                  right: -5,
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 300),
                    painter: RPSCustomPainter(),
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 30,
                  child: const Text(
                    "CREATE ACCOUNT",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
            SignupForm(
              formKey: _formKey,
              nameController: nameController,
              emailController: emailController,
              phoneController: phoneController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              onSignupTap: _handleSignup,
            ),
          ],
        ),
      ),
    );
  }
}
