import 'package:flutter/material.dart';
import 'package:med_care/views/login/widgets/login_button_wrapper.dart';
import 'package:med_care/views/login/widgets/login_form_widget.dart';
import 'package:med_care/views/login/widgets/login_header_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LoginHeaderWidget(), //this is the header
            LoginWidget(),//it contains the textform field for inputing the datas like email and password
            const SizedBox(height: 20),
            LoginButtonWrapper(),//it is the button for navigate to home page if the email and passwords match to the alredy registered user.
          ],
        ),
      ),
    );
  }
}
