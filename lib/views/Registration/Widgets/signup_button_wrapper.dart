import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:med_care/view_model/controller/register_controller.dart';
import 'package:med_care/views/registration/Widgets/registration_button_widget.dart';

class SignupButtonWrapper extends StatelessWidget {
  const SignupButtonWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterController>(
      builder: (context, controller, child) => SignupButton(
        onTap: () => controller.register(context),
        isLoading: controller.isLoading,//when the signupbutton is clicked  it check all the values are correct at that time it will on loading time after the registration is complete it goes to the login page
      ),
    );
  }
}
