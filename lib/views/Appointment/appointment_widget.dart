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
      "imagePath": "assets/icons/doctor1.png",
      "doctorName": "Dr.Johny",
      "specialty": "Cardiologist",
      "date": "June 12, 2025",
      "time": "10:30 AM",
    },
    {
      "imagePath": "assets/icons/doctor2.png",
      "doctorName": "Dr.Lachu",
      "specialty": "Dermatologist",
      "date": "June 13, 2025",
      "time": "02:00 PM",
    },
    {
      "imagePath": "assets/icons/doctor3.png",
      "doctorName": "Dr.Vishnu",
      "specialty": "Neurologist",
      "date": "June 15, 2025",
      "time": "01:00 PM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, User',
                  style: TextStyle(
                    fontFamily: 'oswald',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'How are you feeling today',
                  style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                ),
              ],
            ),
          ),

          SizedBox(height: 30),

          // Appointment button
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const AppointmentDialog(),
              );
            },

            child: Container(
              width: 350,
              height: 150,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/appointment.png',
                    height: 75,
                    width: 175,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Book Appointment",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

          //upcomming appointments
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "Upcommig Appointment",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    print("taped");
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add, size: 18, color: Colors.blue),
                      SizedBox(width: 4),
                      Text(
                        "New",
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
