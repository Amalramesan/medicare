import 'package:flutter/material.dart';
import 'package:med_care/views/Appointment/appointment_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "MediCare",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
        centerTitle: false,
        titleSpacing: 30,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/icons/notification.png',
                height: 27,
                width: 27,
              ),
            ),
          ),
        ],
      ),
      body: HomeWidget(),
    );
  }
}
