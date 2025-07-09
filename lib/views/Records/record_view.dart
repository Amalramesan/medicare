import 'package:flutter/material.dart';
import 'package:med_care/views/Records/Widgets/records_appbar_widget.dart';
import 'package:med_care/views/Records/Widgets/record_list_widget.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: RecordsAppBar(),//it is the app bar used in  the record page and it contains a headinf and a custom button
      body: RecordListWidget(),//it the body of the record page which will display the description of the report, report type and a pdf of the reports.
    );
  }
}
