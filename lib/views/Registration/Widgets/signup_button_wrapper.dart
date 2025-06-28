import 'package:flutter/material.dart';
import 'package:med_care/views/Registration/Widgets/registration_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:med_care/View_model/controller/register_controller.dart';
import 'package:med_care/Models/register_model.dart';

class SignupButtonWrapper extends StatelessWidget {
  const SignupButtonWrapper({super.key});

  void _handleSignup(BuildContext context) async {
    final controller = Provider.of<RegisterController>(context, listen: false);

    final formKey = controller.formKey;
    if (formKey == null || !formKey.currentState!.validate()) return;

    if (controller.genderValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a gender")),
      );
      return;
    }

    final user = User(
      name: controller.nameController!.text.trim(),
      email: controller.emailController!.text.trim(),
      age: int.parse(controller.ageController!.text.trim()),
      place: controller.placeController!.text.trim(),
      gender: controller.genderValue!,
      phoneNumber: controller.phoneController!.text.trim(),
      password: controller.passwordController!.text.trim(),
      confirmpassword: controller.confirmPasswordController!.text.trim(),
    );

    await controller.register(user, context);
  }

  @override
  Widget build(BuildContext context) {
    return SignupButton(onTap: () => _handleSignup(context));
  }
}
