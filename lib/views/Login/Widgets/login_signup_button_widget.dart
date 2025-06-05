import 'package:flutter/material.dart';

class LoginButtonWidget extends StatelessWidget {
  final VoidCallback onTapp;
  const LoginButtonWidget({super.key, required this.onTapp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?", style: TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        InkWell(
          onTap: onTapp,
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
    );
  }
}
