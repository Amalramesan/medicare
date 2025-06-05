import 'package:flutter/material.dart';
import 'package:med_care/utilities/cliper.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
              Text(
                "Please sign in to continue",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
