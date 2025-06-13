import 'package:flutter/material.dart';
import 'package:med_care/Services/api_services.dart';
import 'package:med_care/routes/app_routes.dart';
import 'package:med_care/utilities/tokens.dart';
import 'package:med_care/views/Login/Widgets/login_button_widget.dart';
import 'package:med_care/views/Login/Widgets/login_form_widget.dart';
import 'package:med_care/views/Login/Widgets/login_header_widget.dart';
import 'package:med_care/views/Login/Widgets/login_signup_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logindetails extends StatefulWidget {
  const Logindetails({super.key});

  @override
  State<Logindetails> createState() => _LogindetailsState();
}

class _LogindetailsState extends State<Logindetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await ApiServices().loginuser(
          _emailController.text.trim(),
          _passwordController.text,
        );

        //  Save tokens
        await saveTokens(response.data.access, response.data.refresh);

        // Save patient ID from the login response
        final prefs = await SharedPreferences.getInstance();
        prefs.setInt('patient_id', response.data.user.id);

        // Navigate to home
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.toString()}')),
        );
      }
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
          LoginWidget(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
          ),
          const SizedBox(height: 20),
          LoginButton(onSignInTap: _handleSignIn),
          const SizedBox(height: 20),
          LoginButtonWidget(onTapp: _handleSignUp),
        ],
      ),
    );
  }
}
