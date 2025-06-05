import 'package:flutter/material.dart';
import 'package:med_care/views/Records/Widgets/upload_document_widget.dart';

class RecordsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RecordsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Records",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      actions: const [Recordpagewidget()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
