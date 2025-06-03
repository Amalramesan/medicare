import 'package:flutter/material.dart';
import 'package:med_care/views/Appointment/dialogs/appointments_dialogs.dart';
import 'package:med_care/views/Appointment/list_appointments.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final List<Map<String, String>> appointments = const [
    {
      "imagePath": "assets/images/doctor1.png",
      "doctorName": "Dr.Johny",
      "specialty": "Cardiologist",
      "date": "June 12, 2025",
      "time": "10:30 AM",
    },
    {
      "imagePath": "assets/images/doctor2.png",
      "doctorName": "Dr.Lachu",
      "specialty": "Dermatologist",
      "date": "June 13, 2025",
      "time": "02:00 PM",
    },
    {
      "imagePath": "assets/images/doctor3.png",
      "doctorName": "Dr.Vishnu",
      "specialty": "Neurologist",
      "date": "June 15, 2025",
      "time": "01:00 PM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Greeting
          Container(
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
          ),

          SizedBox(height: screenHeight * 0.03),

          // Appointment button
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const AppointmentDialog(),
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
          ),

          SizedBox(height: screenHeight * 0.02),

          // Upcoming Appointments title
          Padding(
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
          ),

          // List of Appointments
          Column(
            children: appointments.map((appointment) {
              return AppointmentList(
                imagepath: appointment["imagePath"]!,
                doctorName: appointment["doctorName"]!,
                speciality: appointment["specialty"]!,
                date: appointment["date"]!,
                time: appointment["time"]!,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
