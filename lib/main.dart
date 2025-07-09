import 'package:flutter/material.dart';
import 'package:med_care/View_model/controller/apoointment_history_controller.dart';
import 'package:med_care/View_model/controller/appointment_booking_controller.dart';
import 'package:med_care/View_model/controller/bottamnav_controller.dart';
import 'package:med_care/view_model/controller/login_controller.dart';
import 'package:med_care/view_model/controller/profile_controller.dart';
import 'package:med_care/view_model/controller/register_controller.dart';
import 'package:med_care/view_model/controller/report_fetch_controller.dart';
import 'package:med_care/view_model/controller/upload_controller.dart';
import 'package:med_care/routes/app_routes.dart';
import 'package:med_care/view_model/services/store_auth_details.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = LocalStorageService();//this function is responsible for storing and retring tokes ,patient id etc
  await storage.init(); //it is used to Ensuring that the storage is ready for reading/writing keys and values,preventing null or error when accessing storage  later  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider( //these are the controllers that is used in the entire app
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),//it is used for login purpose
        ChangeNotifierProvider(create: (_) => RegisterController()),//used for registering purpose
        ChangeNotifierProvider(create: (_) => BottamnavController()),//it is used for controlling the bottam navigation bar
        ChangeNotifierProvider(create: (_) => ProfileController()),//used for displaying the registered details in the profile page
        ChangeNotifierProvider(
          create: (_) => AppointmentController()..fetchAppointments(), //used for booking appointments and alo used to fetch the appointments
        ),
        ChangeNotifierProvider(create: (_) => UploadController()),//used for uploading purposes
        ChangeNotifierProvider(
          create: (_) => ReportFetchController()..loadReports(),//used for fetching reports
        ),
        ChangeNotifierProvider(create: (_) => AppointmentBookingController()),//used  for the purpose of booking appontments
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash, //the app is starting from splash screen 
        routes: AppRoutes.routes, //and we call the routs that is alredy created in the routes.dart file
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
