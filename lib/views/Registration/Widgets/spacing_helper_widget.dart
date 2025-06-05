import 'package:flutter/widgets.dart';

class SpacingHelperWidget {
  //label padding
  static EdgeInsets labalpadding(BuildContext context) =>
      EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.06);
  //field padding
  static EdgeInsets fieldpadding(BuildContext context) =>
      EdgeInsets.all(MediaQuery.of(context).size.width * 0.03);
  //vertical spacing
  static SizedBox verticalspacesmall = SizedBox(height: 10);
  static SizedBox verticalspacemediam = SizedBox(height: 15);
  //label text
  static Widget label(String text) =>
      Text(text, style: const TextStyle(fontSize: 19));
}
