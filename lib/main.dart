import 'package:flutter/material.dart';
import 'package:med_care/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey[300]),
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: Color.fromARGB(255, 32, 184, 239),
        ),
      ),
    );
  }
}
