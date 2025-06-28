import 'package:flutter/material.dart';

class AppointmentBookingController with ChangeNotifier {
  int _currentStep = 0;
  DateTime? _selectedDate;
  String? _selectedDoctor;
  String? _selectedDoctorId;
  String? _selectedTime;

  int get currentStep => _currentStep;
  DateTime? get selectedDate => _selectedDate;
  String? get selectedDoctor => _selectedDoctor;
  String? get selectedDoctorId => _selectedDoctorId;
  String? get selectedTime => _selectedTime;

  void nextStep() {
    if (_currentStep < 2) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void selectDoctor({required String name, required String id}) {
    _selectedDoctor = name;
    _selectedDoctorId = id;
    notifyListeners();
  }

  void selectTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  void reset() {
    _currentStep = 0;
    _selectedDate = null;
    _selectedDoctor = null;
    _selectedDoctorId = null;
    _selectedTime = null;
    notifyListeners();
  }
}
