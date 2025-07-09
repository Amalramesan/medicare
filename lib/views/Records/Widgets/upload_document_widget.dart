import 'package:flutter/material.dart';
import 'package:med_care/View_model/controller/report_fetch_controller.dart';
import 'package:med_care/views/records/Widgets/record_widget.dart';
import 'package:provider/provider.dart';

class Recordpagewidget extends StatelessWidget {
  const Recordpagewidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: () async {
        // Access the report controller 
        final controller = Provider.of<ReportFetchController>(
          context,
          listen: false,
        );
        //load the report data
        await controller.loadReports();
        if (context.mounted) {
          showDialog(  //used to show a custom dialog after the reports are successfully loaded
            context: context,
            builder: (_) => const DropedownnBodyState(),
          );
        }
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 39, 116, 210),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.upload, color: Colors.white),
            SizedBox(width: 6),
            Text(
              "Upload Documents",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins',
                shadows: [
                  Shadow(
                    blurRadius: 2,
                    color: Colors.black26,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
