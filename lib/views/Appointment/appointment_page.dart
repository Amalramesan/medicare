import 'package:flutter/material.dart';
import 'package:med_care/views/Appointment/appointment_widget.dart';
import 'package:med_care/views/Login/Views/login_view.dart';
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

                // Logout Button
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: const Icon(Icons.logout, size: 27),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false, // Remove all previous routes
                      );
                    },
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
