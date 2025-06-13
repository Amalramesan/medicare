import 'package:flutter/material.dart';
import 'package:med_care/Models/register_model.dart';
import 'package:med_care/Services/api_services.dart';
import 'package:med_care/routes/app_routes.dart';
import 'package:med_care/utilities/tokens.dart';
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

      try {
        User user = User(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          age: int.parse(ageController.text.trim()),
          place: placeController.text.trim(),
          gender: genderValue!,
          phoneNumber: phoneController.text.trim(),
          password: passwordController.text.trim(),
          confirm_password: confirmPasswordController.text.trim(),
        );

        RegisterModel response = await apiServices.registerUser(user);
        await saveUserName(response.data.name);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration Success: ${response.message}")),
        );

        // Navigate to login after success
        Navigator.pushNamed(context, AppRoutes.login);
      } catch (e) {
        print('Registration error: $e');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Registration failed: $e")));
      }
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
