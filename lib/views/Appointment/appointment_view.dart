import 'package:flutter/material.dart';

import 'package:med_care/views/Appointment/Widgets/home_content_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeContent());
  }
}
