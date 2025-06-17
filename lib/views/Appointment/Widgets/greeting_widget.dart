import 'package:flutter/material.dart';
import 'package:med_care/utilities/tokens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GreetingWidget extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  const GreetingWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  State<GreetingWidget> createState() => _GreetingWidgetState();
}

class _GreetingWidgetState extends State<GreetingWidget> {
  String? userName;

  @override
  void initState() {
    super.initState();
    loadUserName();
    debugSharedPrefs();
  }

  void loadUserName() async {
    final name = await getUserName();
    print("Loaded name: $name");
    setState(() {
      userName = name;
    });
  }

  void debugSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('user_name');
    print("DEBUG: user_name in SharedPreferences = $savedName");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: widget.screenWidth * 0.07,
        vertical: widget.screenHeight * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello,${userName ?? "User"}',
            style: TextStyle(
              fontFamily: 'oswald',
              fontSize: widget.screenWidth * 0.07,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: widget.screenHeight * 0.008),
          Text(
            'How are you feeling today',
            style: TextStyle(
              fontSize: widget.screenWidth * 0.045,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
