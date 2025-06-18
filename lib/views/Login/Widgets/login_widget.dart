import 'package:flutter/material.dart';
import 'package:med_care/controller/apoointment_history_controller.dart';
import 'package:med_care/controller/login_controller.dart';
import 'package:med_care/routes/app_routes.dart';
import 'package:med_care/views/Login/Widgets/login_button_widget.dart';
import 'package:med_care/views/Login/Widgets/login_form_widget.dart';
import 'package:med_care/views/Login/Widgets/login_header_widget.dart';
import 'package:med_care/views/Login/Widgets/login_signup_button_widget.dart';
import 'package:provider/provider.dart';

class Logindetails extends StatefulWidget {
  const Logindetails({super.key});

  @override
  State<Logindetails> createState() => _LogindetailsState();
}

class _LogindetailsState extends State<Logindetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleSignUp() {
    Navigator.pushReplacementNamed(context, AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);

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
          loginController.isLoading
              ? const CircularProgressIndicator()
              : LoginButton(
                  onSignInTap: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<AppointmentController>(
                        context,
                        listen: false,
                      ).clearData();
                      loginController.login(
                        email: _emailController.text.trim(),
                        password: _passwordController.text,
                        context: context,
                      );
                    }
                  },
                ),
          const SizedBox(height: 20),
          LoginButtonWidget(onTapp: _handleSignUp),
        ],
      ),
    );
  }
}
