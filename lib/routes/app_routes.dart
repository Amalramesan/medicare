import 'package:flutter/material.dart';
import 'package:med_care/views/Appointment/appointment_view.dart';
import 'package:med_care/views/Login/login_view.dart';
import 'package:med_care/views/Registration/registration_view.dart';
import 'package:med_care/views/splash_screen.dart';
//it is used for managing the routes of entire app
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginPage(),
    register: (context) =>Signup(),
    home: (context) => const HomePage(),
  };
}
