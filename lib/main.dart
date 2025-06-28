import 'package:flutter/material.dart';
import 'package:med_care/View_model/controller/apoointment_history_controller.dart';
import 'package:med_care/View_model/controller/appointment_booking_controller.dart';
import 'package:med_care/View_model/controller/bottamnav_controller.dart';
import 'package:med_care/View_model/controller/login_controller.dart';
import 'package:med_care/View_model/controller/profile_controller.dart';
import 'package:med_care/View_model/controller/register_controller.dart';
import 'package:med_care/View_model/controller/report_fetch_controller.dart';
import 'package:med_care/View_model/controller/upload_controller.dart';
import 'package:med_care/Routes/app_routes.dart';
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
        ChangeNotifierProvider(create: (_) => RegisterController()),
        ChangeNotifierProvider(create: (_) => BottamnavController()),
        ChangeNotifierProvider(
          create: (_) => ProfileController()..loadUserProfile(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppointmentController()..fetchAppointments(),
        ),
        ChangeNotifierProvider(create: (_) => UploadController()),
        ChangeNotifierProvider(
          create: (_) => ReportFetchController()..fetchReports(),
        ),
        ChangeNotifierProvider(create: (_) => AppointmentBookingController()),
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
