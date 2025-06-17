import 'package:flutter/material.dart';
import 'package:med_care/controller/login_controller.dart';
import 'package:med_care/controller/register_controller.dart';
import 'package:med_care/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => RegisterContrller()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
