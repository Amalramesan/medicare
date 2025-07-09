import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:med_care/view_model/controller/login_controller.dart';
import 'package:med_care/routes/app_routes.dart';
import 'package:med_care/views/login/Widgets/login_button_widget.dart';
import 'package:med_care/views/login/Widgets/login_signup_button_widget.dart';
import 'package:provider/provider.dart';
//functionality of login button 
class LoginButtonWrapper extends StatelessWidget {
  const LoginButtonWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final loginControllerr = Provider.of<LoginController>(context);
    log("logincontroller $loginControllerr");

    return Column(
      children: [
        Consumer<LoginController>(
          builder: (context, value, child) => LoginButton(
            isLoading: value.isLoading, //loading
            onSignInTap: () {
              value.login(context: context);
            },
          ),
        ),
        const SizedBox(height: 10),

        const SizedBox(height: 20),
        LoginButtonWidget(
          onTapp: () {
            Navigator.pushReplacementNamed(context, AppRoutes.register);
          },
        ),
      ],
    );
  }
}
