import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:med_care/View_model/controller/report_fetch_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RecordListWidget extends StatefulWidget {
  const RecordListWidget({super.key});

  @override
  State<RecordListWidget> createState() => _RecordListWidgetState();
}

class _RecordListWidgetState extends State<RecordListWidget> {
  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    try {
      final controller = Provider.of<ReportFetchController>(context);

      if (controller.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.reports.isEmpty) {
        return const Center(child: Text("No records found."));
      }

      return ListView.builder(
        itemCount: controller.reports.length,
        itemBuilder: (context, index) {
          final record = controller.reports[index];

          final reportName = record.report;
          final description = record.description;
          final uploadedAt = record.uploadedAt;
          final document = record.document;

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(reportName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description: $description"),
                  Text("Uploaded: $uploadedAt"),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                onPressed: () async {
                  logger.e("Document: $document");

                  if (document.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Invalid document link")),
                    );
                    return;
                  }

                  final fullUrl = document.startsWith('http')
                      ? document
                      : 'http://192.168.29.40:8000/$document';

                  final uri = Uri.parse(fullUrl);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    if(context.mounted){
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Could not open PDF.")),
                    );
                    }
                  }
                },
              ),
            ),
          );
        },
      );
    } catch (e, stackTrace) {
      logger.e(" Caught error in RecordListWidget: $e");
      logger.e(stackTrace);
      return const Center(child: Text("Something went wrong. Check logs."));
    }
  }
}
