import 'package:flutter/material.dart';
import 'package:med_care/Models/register_model.dart';
import 'package:med_care/Services/api_services.dart';
import 'package:med_care/controller/register_controller.dart';
import 'package:med_care/views/Registration/Widgets/registration_button_widget.dart';
import 'package:med_care/views/Registration/Widgets/registration_form_widget.dart';
import 'package:med_care/views/Registration/Widgets/registration_header_widget.dart';
import 'package:med_care/views/Registration/Widgets/spacing_helper_widget.dart';
import 'package:provider/provider.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ageController = TextEditingController();
  final placeController = TextEditingController();
  String? genderValue;

  final ApiServices apiServices = ApiServices();

  final _formKey = GlobalKey<FormState>();

  void _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      if (genderValue == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Please select a gender")));
        return;
      }

      final user = User(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        age: int.parse(ageController.text.trim()),
        place: placeController.text.trim(),
        gender: genderValue!,
        phoneNumber: phoneController.text.trim(),
        password: passwordController.text.trim(),
        confirm_password: confirmPasswordController.text.trim(),
      );

      final registercontroller = Provider.of<RegisterContrller>(
        context,
        listen: false,
      );
      await registercontroller.register(user, context);
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
          SignupForm(
            formKey: _formKey,
            nameController: nameController,
            emailController: emailController,
            phoneController: phoneController,
            passwordController: passwordController,
            confirmPasswordController: confirmPasswordController,
            ageController: ageController,
            placeController: placeController,
            genderValue: genderValue,
            onGenderChanged: (value) {
              setState(() => genderValue = value);
            },
          ),
          SpacingHelperWidget.verticalspacemediam,

          // SignUp Button
          SignupButton(onTap: _handleSignup),
        ],
      ),
    );
  }
}
