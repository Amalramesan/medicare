import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onSignInTap;
  const LoginButton({super.key, required this.onSignInTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(15),
          child: InkWell(
            onTap: onSignInTap,
            child: SizedBox(
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
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
