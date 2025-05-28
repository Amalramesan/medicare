import 'package:flutter/material.dart';
import 'package:med_care/views/Appointment/appointment_page.dart';
import 'package:med_care/views/Login_page/login.dart';
import 'package:med_care/views/Regerstration/regerstration.dart';
import 'package:med_care/views/Splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginPage(),
    register: (context) => const Signup(),
    home: (context) => const HomePage(),
  };
}
