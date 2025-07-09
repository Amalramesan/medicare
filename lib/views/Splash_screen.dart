import 'package:flutter/material.dart';
import 'package:med_care/views/Appointment/appointment_view.dart';
import 'package:med_care/views/Login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); //this function is a one time process so it called in initstate
  }

  Future<void> _checkLoginStatus() async { //this is the function used for checking the person is loged in or not
    await Future.delayed(const Duration(seconds: 2)); 
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (!mounted) return;

    if (token != null && token.isNotEmpty) { //this condition is used to check the token is empty or not
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),//if not empty go to the home page
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()), //if empty go to the  login page 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/images/medcare_logo.png')),//this is the logo used for splash screen
    );
  }
}
