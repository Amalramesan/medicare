import 'package:flutter/material.dart';
import 'package:med_care/Common/custom_text_field.dart';
import 'package:med_care/utilities/validators.dart';

class LoginWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const LoginWidget({super.key, required this.formKey});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;

    return Column(
      children: [
        Form(
          key: widget.formKey,
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
                  controller: _emailController,
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
                  controller: _passwordController,
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
