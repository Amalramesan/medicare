// widgets/home_content.dart
import 'package:flutter/material.dart';
import 'package:med_care/views/Appointment/Widgets/appointment_widget.dart';
import 'package:med_care/views/Appointment/Widgets/custom_appbar_widget.dart';
import 'package:med_care/views/Appointment/Widgets/custom_bottam_nav_widget.dart';
import 'package:med_care/views/Profile/profile_view.dart';
import 'package:med_care/views/Records/record_view.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomeWidget(), RecordPage(), ProfileView()];

  void _onItemTapped(int index) {
    if (index >= 0 && index < _pages.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? const CustomAppBar() : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
