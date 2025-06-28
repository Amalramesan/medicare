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
      HomeWidget(),
      RecordPage(),
      ProfileView(),
    ];

    return pages[selectedIndex];
  }
}
