import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "MediCare",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
      centerTitle: false,
      titleSpacing: 30,
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              // Handle notification tap
            },
            child: Image.asset(
              'assets/icons/notification.png',
              height: 27,
              width: 27,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
