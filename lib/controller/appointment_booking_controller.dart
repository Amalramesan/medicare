// import 'package:flutter/material.dart';

// class AppointmentBookingController with ChangeNotifier {
//   int _currentStep = 0;
//   DateTime? selectedDate;
//   String? selectedDoctor;
//   String? selectedDoctorId;
//   String? selectedTime;

//   int get currentStep => _currentStep;

//   void nextStep() {
//     if (_currentStep < 2) {
//       _currentStep++;
//       notifyListeners();
//     }
//   }

//   void previousStep() {
//     if (_currentStep > 0) {
//       _currentStep--;
//       notifyListeners();
//     }
//   }

//   void setDate(DateTime date) {
//     selectedDate = date;
//     notifyListeners();
//   }

//   void setDoctor(String doctorName, String doctorId) {
//     selectedDoctor = doctorName;
//     selectedDoctorId = doctorId;
//     notifyListeners();
//   }

//   void setTime(String time) {
//     selectedTime = time;
//     notifyListeners();
//   }
// }
