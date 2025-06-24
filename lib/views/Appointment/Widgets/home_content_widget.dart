import 'package:flutter/material.dart';
import 'package:med_care/controller/bottamnav_controller.dart';
import 'package:med_care/views/Appointment/Widgets/appointment_widget.dart';
import 'package:med_care/views/Appointment/Widgets/custom_appbar_widget.dart';
import 'package:med_care/views/Appointment/Widgets/custom_bottam_nav_widget.dart';
import 'package:med_care/views/Profile/profile_view.dart';
import 'package:med_care/views/Records/record_view.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<Widget> _pages = [HomeWidget(), RecordPage(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<BottamnavController>(context);
    int selectIndex = navProvider.selectIndex;

    return Scaffold(
      appBar: selectIndex == 0 ? const CustomAppBar() : null,
      body: _pages[selectIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: selectIndex,
        onTap: navProvider.setIndex,
      ),
    );
  }
}
