import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:med_care/Common/Widgets/custom_text_field.dart';
import 'package:med_care/utilities/cliper.dart';

class SignupForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController placecontroller;
  final TextEditingController agecontroller;
  final VoidCallback onSignupTap;

  const SignupForm({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.placecontroller,
    required this.agecontroller,
    required this.onSignupTap,
  }) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  String? genderValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 300),
                painter: RPSCustomPainter(),
              ),
              Positioned(
                top: 16,
                right: -5,
                child: CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 300),
                  painter: RPSCustomPainter(),
                ),
              ),
              Positioned(
                top: 200,
                left: 30,
                child: const Text(
                  "CREATE ACCOUNT",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),

          Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: const Text("Name", style: TextStyle(fontSize: 19)),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: CustomTextField(
                    hintText: 'Enter your name',
                    icon: Icons.person,
                    controller: widget.nameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name is required';
                      }
                      final nameregp = RegExp(r"^[a-zA-Z\s'-]+$");
                      if (!nameregp.hasMatch(value.trim())) {
                        return "Enter a valid name";
                      }
                      if (value.trim().length < 2) {
                        return 'Name is too short';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: const Text("Email", style: TextStyle(fontSize: 19)),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: CustomTextField(
                    hintText: "Enter your Email",
                    icon: Icons.email,
                    controller: widget.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: const Text(
                    "Phone Number",
                    style: TextStyle(fontSize: 19),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: CustomTextField(
                    hintText: "Enter your phone number",
                    icon: Icons.phone,
                    controller: widget.phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter phone number";
                      }
                      if (value.length < 10) {
                        return "Phone number must contain at least 10 characters";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.02,
                              ),
                              child: const Text(
                                "Age",
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Card(
                              color: Colors.grey[150],
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                controller: widget.agecontroller,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your age';
                                  }
                                  final age = int.tryParse(value);
                                  if (age == null || age <= 0) {
                                    return 'Enter a valid age';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.date_range_outlined),
                                  hintText: "Age",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Gender",
                              style: TextStyle(fontSize: 19),
                            ),
                            const SizedBox(height: 5),
                            Card(
                              color: Colors.grey[150],
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: genderValue,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                  ),
                                  hint: const Text("Gender"),
                                  items: ['Male', 'Female', 'Other'].map((
                                    String value,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      genderValue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: CustomTextField(
                    hintText: "Enter your place",
                    icon: Icons.place,
                    controller: widget.placecontroller,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a place';
                      }
                      final placeRegExp = RegExp(r'^[a-zA-Z\s]+$');
                      if (!placeRegExp.hasMatch(value)) {
                        return 'Place should contain only letters';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: const Text("Password", style: TextStyle(fontSize: 19)),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: CustomTextField(
                    hintText: "Enter your password",
                    icon: Icons.password,
                    controller: widget.passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }

                      final passwordRegex = RegExp(
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                      );

                      if (!passwordRegex.hasMatch(value)) {
                        return 'Password must be at least 8 characters,\ninclude upper and lower case letters,\na number and a special character.';
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.055,
                  ),
                  child: const Text(
                    "Confirm Password",
                    style: TextStyle(fontSize: 19),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
                  child: CustomTextField(
                    hintText: "Re-enter the password",
                    icon: Icons.password,
                    controller: widget.confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Confirm Password is required";
                      }

                      if (value != widget.passwordController.text) {
                        return "Passwords do not match";
                      }

                      final passwordRegex = RegExp(
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                      );

                      if (!passwordRegex.hasMatch(value)) {
                        return 'Password must be at least 8 characters,\ninclude upper and lower case letters,\na number and a special character.';
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTap: widget.onSignupTap,
                        child: Container(
                          height: 50,
                          width: 150,
                          child: Card(
                            color: const Color.fromARGB(255, 32, 184, 239),
                            elevation: 5,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "SIGNUP",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
