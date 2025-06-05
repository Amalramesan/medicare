import 'package:flutter/material.dart';
import 'package:med_care/routes/app_routes.dart';
import 'package:med_care/views/Registration/Widgets/registration_button_widget.dart';
import 'package:med_care/views/Registration/Widgets/registration_form_widget.dart';
import 'package:med_care/views/Registration/Widgets/registration_header_widget.dart';
import 'package:med_care/views/Registration/Widgets/spacing_helper_widget.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final _formKey = GlobalKey<FormState>();

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          const SignupHeaderWidget(),
          SpacingHelperWidget.verticalspacesmall,

          // Form with fields
          SignupForm(formKey: _formKey),
          SpacingHelperWidget.verticalspacemediam,

          // SignUp Button
          SignupButton(onTap: _handleSignup),
        ],
      ),
    );
  }
}
