import 'package:flutter/material.dart';
import 'package:med_care/views/registration/widgets/registration_header_widget.dart';
import 'package:med_care/views/registration/widgets/signup_button_wrapper.dart';
import 'package:med_care/views/registration/widgets/registration_form_widget.dart'; 
import 'package:med_care/views/registration/widgets/spacing_helper_widget.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SignupHeaderWidget(), // this is the heading of the page
            SpacingHelperWidget.verticalspacesmall, //used for giving vertical sapce
            SignupForm(),//it is the  signup form which is used for entering the datas like name,email,place,age,password
            SpacingHelperWidget.verticalspacemediam,//also used for give spacing
            SignupButtonWrapper(),//it is the button that helps to go to the next page only when all the vailidations are true
          ],
        ),
      ),
    );
  }
}
