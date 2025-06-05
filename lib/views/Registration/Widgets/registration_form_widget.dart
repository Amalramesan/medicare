import 'package:flutter/material.dart';
import 'package:med_care/Common/custom_text_field.dart';
import 'package:med_care/utilities/validators.dart';
import 'package:med_care/views/Registration/Widgets/gender_and_age_widget.dart';
import 'package:med_care/views/Registration/Widgets/spacing_helper_widget.dart';

class SignupForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const SignupForm({super.key, required this.formKey});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ageController = TextEditingController();
  final placeController = TextEditingController();

  String? genderValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //fields of textform fields
          Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Padding(
                  padding: SpacingHelperWidget.labalpadding(context),
                  child: SpacingHelperWidget.label("Name"),
                ),
                Padding(
                  padding: SpacingHelperWidget.fieldpadding(context),
                  child: CustomTextField(
                    hintText: 'Enter your name',
                    icon: Icons.person,
                    controller: nameController,
                    validator: Validators.validatename,
                  ),
                ),

                // Email
                Padding(
                  padding: SpacingHelperWidget.labalpadding(context),
                  child: SpacingHelperWidget.label("Email"),
                ),
                Padding(
                  padding: SpacingHelperWidget.fieldpadding(context),
                  child: CustomTextField(
                    hintText: "Enter your Email",
                    icon: Icons.email,
                    controller: emailController,
                    validator: Validators.validateEmail,
                  ),
                ),

                // Phone
                Padding(
                  padding: SpacingHelperWidget.labalpadding(context),
                  child: SpacingHelperWidget.label("Phone number"),
                ),
                Padding(
                  padding: SpacingHelperWidget.fieldpadding(context),
                  child: CustomTextField(
                    hintText: "Enter your phone number",
                    icon: Icons.phone,
                    controller: phoneController,
                    validator: Validators.validatePhone,
                  ),
                ),

                // Age & Gender Row
                GenderAgeRowWidget(
                  ageController: ageController,
                  genderValue: genderValue,
                  onGenderChanged: (value) {
                    setState(() => genderValue = value);
                  },
                ),

                // Place
                Padding(
                  padding: SpacingHelperWidget.labalpadding(context),
                  child: SpacingHelperWidget.label("Place"),
                ),
                Padding(
                  padding: SpacingHelperWidget.fieldpadding(context),
                  child: CustomTextField(
                    hintText: "Enter your place",
                    icon: Icons.place,
                    controller: placeController,
                    validator: Validators.validatePlace,
                  ),
                ),

                // Password
                Padding(
                  padding: SpacingHelperWidget.labalpadding(context),
                  child: SpacingHelperWidget.label("Password"),
                ),
                Padding(
                  padding: SpacingHelperWidget.fieldpadding(context),
                  child: CustomTextField(
                    hintText: "Enter your password",
                    icon: Icons.password,
                    controller: passwordController,
                    obscureText: true,
                    validator: Validators.validatePassword,
                  ),
                ),

                // Confirm Password
                Padding(
                  padding: SpacingHelperWidget.labalpadding(context),
                  child: SpacingHelperWidget.label("Confirm Password"),
                ),
                Padding(
                  padding: SpacingHelperWidget.fieldpadding(context),
                  child: CustomTextField(
                    hintText: "Re-enter the password",
                    icon: Icons.password,
                    controller: confirmPasswordController,
                    obscureText: true,
                    validator: (value) => Validators.validateConfirmPassword(
                      value,
                      passwordController.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
