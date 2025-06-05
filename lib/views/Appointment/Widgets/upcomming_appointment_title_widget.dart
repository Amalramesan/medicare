import 'package:flutter/material.dart';

class AppointmentsTitleWidget extends StatelessWidget {
  final double screenWidth;

  const AppointmentsTitleWidget({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
      child: Row(
        children: [
          Text(
            "Upcoming Appointment",
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
