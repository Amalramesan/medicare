import 'package:flutter/material.dart';
import 'package:med_care/views/Appointment/appointment_page.dart';
import 'package:med_care/views/Login/Views/login_view.dart';
import 'package:med_care/views/Registration/View/registration.dart';
import 'package:med_care/views/Splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    login: (context) => LoginPage(),
    register: (context) => Signup(),
    home: (context) => const HomePage(),
  };
}
