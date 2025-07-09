// home_content_widget.dart
import 'package:flutter/material.dart';
import 'package:med_care/View_model/controller/bottamnav_controller.dart';
import 'package:med_care/views/Appointment/Widgets/appointment_widget.dart';
import 'package:med_care/views/Profile/profile_view.dart';
import 'package:med_care/views/Records/record_view.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<BottamnavController>(context);
    final int selectedIndex = navProvider.selectIndex;

    final List<Widget> pages = [
      //this code defines the homewidget which show a greeting,provide a button to book appointments,display the list of 
      //existing appointments ,handles loading error, and empty states,allow user to cancel appointments, and uses the appointment controller for statemanagement
      HomeWidget(),
      //it contains a record page where user can upload their medical reports and display in the page.
      RecordPage(),
      //it is used for viewing the profile of registered user.
      ProfileView(),
    ];

    return pages[selectedIndex];
  }
}
