import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const SignupButton({
    super.key,
    required this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(15),
          child: InkWell(
            onTap: isLoading ? null : onTap, // Disable tap if loading
            child: SizedBox(
              height: 50,
              width: 150,
              child: Card(
                color: const Color.fromARGB(255, 32, 184, 239),
                elevation: 5,
                child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Row(
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
    );
  }
}
