import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:med_care/View_model/controller/report_fetch_controller.dart';
import 'package:med_care/data/response/status.dart';
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
    final controller = Provider.of<ReportFetchController>(context);
    final response = controller.reportsResponse;

    switch (response.status) {
      case Status.loading://loading
        return const Center(child: CircularProgressIndicator());

      case Status.error:
        return Center(child: Text(response.message ?? "Something went wrong"));

      case Status.completed://completed
        final reports = response.data ?? [];

        if (reports.isEmpty) {
          return const Center(child: Text("No records found."));
        }

        return ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            final record = reports[index];

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
                    logger.i("Opening document: $document");

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
                      if (context.mounted) {
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

      default:
        return const SizedBox(); // fallback
    }
  }
}
