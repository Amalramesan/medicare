import 'package:flutter/material.dart';
import 'package:med_care/views/Appointment/appointment_widget.dart';
import 'package:med_care/views/Login/Viewss/login_view.dart';
import 'package:med_care/views/Profile/View/profile_view.dart';
import 'package:med_care/views/records/record_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [HomeWidget(), RecordPage(), ProfileView()];
  void onItemtapped(int index) {
    if (index >= 0 && index < _pages.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
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
                // Notification Icon
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      // Handle notification tap
                    },
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
