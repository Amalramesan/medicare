import 'package:flutter/material.dart';
import 'package:med_care/views/Appointment/appointment_widget.dart';
import 'package:med_care/views/records/record_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [HomeWidget(), RecordPage()];
  void onItemtapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
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
            )
          : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onItemtapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Appointments",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: "Records"),
        ],
      ),
    );
  }
}
