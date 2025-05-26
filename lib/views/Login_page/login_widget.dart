import 'package:flutter/material.dart';
import 'package:med_care/utilities/cliper.dart';

// Pass in controllers and callbacks as parameters to keep it reusable
class LoginWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSignInTap;
  final VoidCallback onSignUpTap;

  const LoginWidget({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSignInTap,
    required this.onSignUpTap,
  }) : super(key: key);

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      "Please sign in to continue",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 16,
                        ),
                        border: InputBorder.none,
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
                // Password
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.055,
                  ),
                  child: const Text("Password", style: TextStyle(fontSize: 19)),
                ),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.03,
                  ),
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
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 16,
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password";
                        }
                        if (value.length < 6) {
                          return "Password must contain at least 6 characters";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTap: onSignInTap,
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
                                    "LOGIN",
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onSignUpTap,
                      child: const Text(
                        "SIGNUP",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 32, 184, 239),
                          fontWeight: FontWeight.bold,
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
