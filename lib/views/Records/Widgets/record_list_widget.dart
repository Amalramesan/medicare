import 'package:flutter/material.dart';
import 'package:med_care/Models/report_fetch_model.dart';
import 'package:med_care/services/api_services.dart';
import 'package:url_launcher/url_launcher.dart';

class RecordListWidget extends StatefulWidget {
  const RecordListWidget({super.key});

  @override
  State<RecordListWidget> createState() => _RecordListWidgetState();
}

class _RecordListWidgetState extends State<RecordListWidget> {
  late Future<ReportFetchModel?> _futureReports;
  @override
  void initState() {
    super.initState();
    _futureReports = ApiServices.fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ReportFetchModel?>(
        future: _futureReports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Failed to fetch records."));
          }

          final dataList = snapshot.data!.data;

          if (dataList.isEmpty) {
            return const Center(child: Text("No records found."));
          }

          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final record = dataList[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(record.report),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Description: ${record.description}"),
                      Text("Uploaded: ${record.uploadedAt}"),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                    onPressed: () async {
                      const baseUrl = 'http://192.168.29.40:8000';

                      if (record.document.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Document path is empty."),
                          ),
                        );
                        return;
                      }

                      final relativePath = record.document.startsWith('/')
                          ? record.document
                          : '/${record.document}';

                      final fullUrl = record.document.startsWith('http')
                          ? record.document
                          : '$baseUrl$relativePath';

                      final uri = Uri.parse(fullUrl);
                      print("PDF URL: $fullUrl");
                      print("Opening PDF at: $uri");

                      if (await canLaunchUrl(uri)) {
                        final success = await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );

                        if (!success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Failed to launch PDF viewer."),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Could not open the PDF file."),
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
