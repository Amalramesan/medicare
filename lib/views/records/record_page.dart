import 'package:flutter/material.dart';
import 'package:med_care/views/records/record_page.widgets.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
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
