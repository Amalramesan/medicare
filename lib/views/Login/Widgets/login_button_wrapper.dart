import 'package:flutter/material.dart';
import 'package:med_care/View_model/controller/apoointment_history_controller.dart';
import 'package:med_care/View_model/controller/login_controller.dart';
import 'package:med_care/Routes/app_routes.dart';
import 'package:med_care/views/Login/Widgets/login_button_widget.dart';
import 'package:med_care/views/Login/Widgets/login_signup_button_widget.dart';
import 'package:provider/provider.dart';

class LoginButtonWrapper extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButtonWrapper({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  void _handleSignUp(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);

    return Column(
      children: [
        LoginButton(
          isLoading: loginController.isLoading,
          onSignInTap: () {
            if (formKey.currentState!.validate()) {
              Provider.of<AppointmentController>(
                context,
                listen: false,
              ).clearData();
              loginController.login(
                email: emailController.text.trim(),
                password: passwordController.text,
                context: context,
              );
            }
          },
        ),
        const SizedBox(height: 20),
        LoginButtonWidget(onTapp: () => _handleSignUp(context)),
      ],
    );
  }
}
