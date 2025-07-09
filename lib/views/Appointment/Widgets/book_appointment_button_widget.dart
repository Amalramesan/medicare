import 'package:flutter/material.dart';
import 'package:med_care/view_model/controller/appointment_booking_controller.dart';
import 'package:provider/provider.dart';
import 'appointment_booking_dialog_widget.dart';
//button for booking appointments
class BookAppointmentButton extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const BookAppointmentButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ChangeNotifierProvider(
            create: (_) => AppointmentBookingController(),
            child: const AppointmentDialog(),
          ),
        );
      },
      child: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.2,
        padding: EdgeInsets.all(screenWidth * 0.05),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/icons/appointment.png',
              height: screenHeight * 0.09,
              width: screenWidth * 0.5,
              fit: BoxFit.contain,
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Book Appointment",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * 0.045,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
