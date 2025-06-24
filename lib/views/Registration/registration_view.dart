import 'package:flutter/material.dart';
import 'package:med_care/views/Registration/Widgets/registration_header_widget.dart';
import 'package:med_care/views/Registration/Widgets/signup_button_wrapper.dart';
import 'package:med_care/views/Registration/Widgets/signup_form_wrapper.dart';
import 'package:med_care/views/Registration/Widgets/spacing_helper_widget.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SignupHeaderWidget(),//header widget
          SpacingHelperWidget.verticalspacesmall,//for spacing
          SignupFormWrapper(),//textfields
           SpacingHelperWidget.verticalspacemediam,
          SignupButtonWrapper(),//signup buttons
        ],
      )
      );
  }
}
