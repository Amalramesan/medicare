import 'package:flutter/material.dart';
import 'package:med_care/res/custom_text_field.dart';
import 'package:med_care/view_model/controller/login_controller.dart';
import 'package:med_care/view_model/services/validators.dart';
import 'package:provider/provider.dart';
//textform fileds for the user to enter login and password
class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    return Consumer<LoginController>(
      builder:
          (
            BuildContext context,
            LoginController controller,
            Widget? child,
          ) => Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [     
                Padding(
                  padding: EdgeInsets.only(left: sizes.width * 0.05),
                  child: const Text("Email", style: TextStyle(fontSize: 19)),
                ),
                Padding(
                  padding: EdgeInsets.all(sizes.width * 0.03),
                  child: CustomTextField(
                    hintText: 'Enter your email',
                    icon: Icons.email,
                    obscureText: false,
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.validateEmail,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: sizes.width * 0.05),
                  child: const Text("Password", style: TextStyle(fontSize: 19)),
                ),
                Padding(
                  padding: EdgeInsets.all(sizes.width * 0.03),
                  child: CustomTextField(
                    hintText: "Enter your password",
                    icon: Icons.password,
                    controller: controller.passwordController,
                    obscureText: true,
                    validator: Validators.validatePassword,
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
