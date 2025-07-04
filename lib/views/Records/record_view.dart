import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:med_care/View_model/controller/report_fetch_controller.dart';
import 'package:med_care/views/Records/Widgets/records_appbar_widget.dart';
import 'package:med_care/views/Records/Widgets/record_list_widget.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportFetchController()..fetchReports(),
      child: const Scaffold(appBar: RecordsAppBar(), body: RecordListWidget()),
    );
  }
}
