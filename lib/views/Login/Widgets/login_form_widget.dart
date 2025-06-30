import 'package:flutter/material.dart';
import 'package:med_care/Common/custom_text_field.dart';
import 'package:med_care/Services/validators.dart';


class LoginWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginWidget({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;

    return Form(
      key: formKey,
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
              controller: emailController,
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
              controller: passwordController,
              obscureText: true,
              validator: Validators.validatePassword,
            ),
          ),
        ],
      ),
    );
  }
}
