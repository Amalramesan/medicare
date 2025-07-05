import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:med_care/Data/response/status.dart';

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
    return Consumer<ReportFetchController>(
      builder: (context, controller, child) {
        final response = controller.reportsResponse;
        logger.i("First record: ${response.data?.first.toJson()}");

        logger.i("response.status: ${response.status}");
        logger.i("response.data: ${response.data}");

        switch (response.status!) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());

          case Status.error:
            return Center(
              child: Text(response.message ?? "Something went wrong"),
            );

          case Status.completed:
            final reports = response.data ?? [];

            if (reports.isEmpty) {
              return const Center(child: Text("No records found."));
            }

            return SafeArea(
              child: ListView.builder(
                itemCount: reports.length,
                padding: const EdgeInsets.only(bottom: 16),
                itemBuilder: (context, index) {
                  final record = reports[index];

                  final reportName = record.report.isNotEmpty
                      ? record.report
                      : "Unknown Report";
                  final description = record.description.isNotEmpty
                      ? record.description
                      : "No description";
                  final uploadedAt = record.uploadedAt.isNotEmpty
                      ? record.uploadedAt
                      : "No date";
                  final document = record.document.trim();

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
                        icon: const Icon(
                          Icons.picture_as_pdf,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          logger.i("Opening document: $document");

                          if (document.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Invalid document link"),
                              ),
                            );
                            return;
                          }

                          final baseUrl = 'http://192.168.29.112:8000';
                          final fullUrl = document.startsWith('http')
                              ? document
                              : '$baseUrl${document.startsWith("/") ? "" : "/"}$document';

                          final uri = Uri.parse(fullUrl);

                          if (await canLaunchUrl(uri)) {
                            await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Could not open PDF."),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            );
        }
      },
    );
  }
}
