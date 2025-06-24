// home_page.dart
import 'package:flutter/material.dart';
import 'package:med_care/controller/bottamnav_controller.dart';
import 'package:med_care/views/Appointment/Widgets/custom_appbar_widget.dart';
import 'package:med_care/views/Appointment/Widgets/custom_bottam_nav_widget.dart';
import 'package:med_care/views/Appointment/Widgets/home_content_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<BottamnavController>(context);
    final int selectedIndex = navProvider.selectIndex;

    return Scaffold(
      appBar: selectedIndex == 0 ? const CustomAppBar() : null,
      body: const HomeContent(),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: selectedIndex,
        onTap: navProvider.setIndex,
      ),
    );
  }
}
