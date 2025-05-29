import 'package:flutter/material.dart';
import 'package:med_care/views/records/record_page.widgets.dart'; // corrected filename
import 'package:med_care/views/records/dialog_records.dart'; // DialogList lives here

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.grey[300],
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Records",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [Recordpagewidget()],
        ),
      ),
      body: const Center(child: Text("records")),
    );
  }
}
