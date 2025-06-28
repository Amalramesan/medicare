import 'package:flutter/material.dart';
import 'package:med_care/views/Registration/Widgets/registration_form_widget.dart';
import 'package:provider/provider.dart';
import 'package:med_care/View_model/controller/register_controller.dart';

class SignupFormWrapper extends StatefulWidget {
  const SignupFormWrapper({super.key});

  @override
  State<SignupFormWrapper> createState() => _SignupFormWrapperState();
}

class _SignupFormWrapperState extends State<SignupFormWrapper> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ageController = TextEditingController();
  final placeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final controller = Provider.of<RegisterController>(context, listen: false);
    controller.setFormKey(formKey);
    controller.setControllers(
      name: nameController,
      email: emailController,
      phone: phoneController,
      password: passwordController,
      confirmPassword: confirmPasswordController,
      age: ageController,
      place: placeController,
    );
  }

  @override
  Widget build(BuildContext context) {
    final genderValue = Provider.of<RegisterController>(context).genderValue;

    return SignupForm(
      formKey: formKey,
      nameController: nameController,
      emailController: emailController,
      phoneController: phoneController,
      passwordController: passwordController,
      confirmPasswordController: confirmPasswordController,
      ageController: ageController,
      placeController: placeController,
      genderValue: genderValue,
      onGenderChanged: (value) {
        Provider.of<RegisterController>(context, listen: false)
            .setGenderValue(value);
      },
    );
  }
}
