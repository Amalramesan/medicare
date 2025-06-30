import 'package:flutter/material.dart';
import 'package:med_care/Common/custom_text_field.dart';
import 'package:med_care/Services/validators.dart';
import 'package:med_care/views/Registration/Widgets/gender_and_age_widget.dart';
import 'package:med_care/views/Registration/Widgets/spacing_helper_widget.dart';

class SignupForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController ageController;
  final TextEditingController placeController;
  final String? genderValue;
  final Function(String?) onGenderChanged;
  const SignupForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.ageController,
    required this.placeController,
    this.genderValue,
    required this.onGenderChanged,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
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
                    controller: widget.nameController,
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
                    controller: widget.emailController,
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
                    controller: widget.phoneController,
                    validator: Validators.validatePhone,
                  ),
                ),

                // Age & Gender Row
                GenderAgeRowWidget(
                  ageController: widget
                      .ageController, // this comes from your widget parameter
                  genderValue: widget
                      .genderValue, // this comes from your widget parameter
                  onGenderChanged: widget
                      .onGenderChanged, // this comes from your widget parameter
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
                    controller: widget.placeController,
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
                    controller: widget.passwordController,
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
                    controller: widget.confirmPasswordController,
                    obscureText: true,
                    validator: (value) => Validators.validateConfirmPassword(
                      value,
                      widget.passwordController.text,
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
