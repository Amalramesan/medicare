import 'package:flutter/material.dart';
import 'package:med_care/Res/custom_text_field.dart';
import 'package:med_care/View_model/services/validators.dart';
import 'package:med_care/views/registration/widgets/spacing_helper_widget.dart';
import 'package:med_care/views/registration/widgets/gender_and_age_widget.dart';
import 'package:provider/provider.dart';
import 'package:med_care/view_model/controller/register_controller.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterController>( //consumer is used because it only rebuild the particular widget
      builder:
          (BuildContext context, RegisterController controller, Widget? child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Padding( //it is the text field for name
                          padding: SpacingHelperWidget.labalpadding(context),
                          child: SpacingHelperWidget.label("Name"),
                        ),
                        Padding(
                          padding: SpacingHelperWidget.fieldpadding(context),
                          child: CustomTextField(//it is a custom text field that can be reused
                            hintText: 'Enter your name',
                            icon: Icons.person,
                            controller: controller.nameController,
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
                            controller: controller.emailController,
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
                            controller: controller.phoneController,
                            validator: Validators.validatePhone,
                          ),
                        ),

                        // Age & Gender Row
                        GenderAgeRowWidget(
                          ageController: controller.ageController,
                          genderValue: controller.genderValue,
                          onGenderChanged: controller.setGenderValue,
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
                            controller: controller.placeController,
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
                            controller: controller.passwordController,
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
                            controller: controller.confirmPasswordController,
                            obscureText: true,
                            validator: (value) =>
                                Validators.validateConfirmPassword(
                                  value,
                                  controller.passwordController.text,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
    );
  }
}
