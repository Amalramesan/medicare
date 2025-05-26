import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onSignupTap;

  const SignupForm({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onSignupTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name Field
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
            ),
            child: const Text("Name", style: TextStyle(fontSize: 19)),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            child: Card(
              color: Colors.grey[350],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Full name",
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                ),
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
          ),

          const SizedBox(height: 10),

          // Email Field
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
            ),
            child: const Text("Email", style: TextStyle(fontSize: 19)),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            child: Card(
              color: Colors.grey[350],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                ),
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
          ),

          const SizedBox(height: 10),

          // Phone Number Field
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
            ),
            child: const Text("Phone Number", style: TextStyle(fontSize: 19)),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            child: Card(
              color: Colors.grey[350],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone_android),
                  hintText: "Phone number",
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                ),
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
          ),

          const SizedBox(height: 10),

          // Password Field
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
            ),
            child: const Text("Password", style: TextStyle(fontSize: 19)),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            child: Card(
              color: Colors.grey[350],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Password",
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Confirm Password Field
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
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            child: Card(
              color: Colors.grey[350],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                obscureText: true,
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Confirm Password",
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Signup Button
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  onTap: onSignupTap,
                  child: Container(
                    height: 50,
                    width: 150,
                    child: Card(
                      color: Color.fromARGB(255, 32, 184, 239),
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
                            Icon(Icons.arrow_forward, color: Colors.white),
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
    );
  }
}
