import 'package:flutter/material.dart';

class GreetingWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const GreetingWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.07,
        vertical: screenHeight * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, User',
            style: TextStyle(
              fontFamily: 'oswald',
              fontSize: screenWidth * 0.07,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.008),
          Text(
            'How are you feeling today',
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
