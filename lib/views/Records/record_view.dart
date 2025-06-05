import 'package:flutter/material.dart';
import 'package:med_care/views/Records/Widgets/records_appbar_widget.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: RecordsAppBar(),
      body: Center(child: Text("records")),
    );
  }
}
