import 'package:flutter/material.dart';
import 'package:med_care/view_model/services/store_auth_details.dart';
import 'package:med_care/models/appointment_history_model.dart';
import 'package:med_care/repository/appointment_resporitary.dart';
//this is the appointment colteroller for controlling the appointment state
// Handles:
// - Fetching appointments for a logged-in patient
// - Booking new appointments
// - Cancelling appointments
class AppointmentController with ChangeNotifier {
  final _repository = AppointmentRepository();
  final _storage = LocalStorageService();

  List<AppointmentHistoryModel> _appointments = [];
  bool _isLoading = false;
  String? _error;

  List<AppointmentHistoryModel> get appointments => _appointments;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _updateState({
    required bool loading,
    String? error,
    List<AppointmentHistoryModel>? data,
  }) {
    _isLoading = loading;
    _error = error;
    if (data != null) _appointments = data;
    notifyListeners();
  }
//used to fetch the appointments
  Future<void> fetchAppointments() async {
    _updateState(loading: true, error: null);
    try {
      await _storage.init();
      final id = _storage.patientId;
      if (id == null) {
        _updateState(loading: false, error: "Patient ID not found", data: []);
        return;
      }
      final data = await _repository.fetchPatientAppointments(patientId: id);
      _updateState(loading: false, data: data);
    } catch (e) {
      _updateState(loading: false, error: "Fetch failed: $e", data: []);
    }
  }
//used to book appointments
  Future<void> bookAppointment({
    required int doctorId,
    required String date,
    required String time,
  }) async {
    _updateState(loading: true, error: null);
    try {
      await _storage.init();
      final id = _storage.patientId;
      if (id == null) {
        _updateState(loading: false, error: "Patient ID not found");
        return;
      }

      final result = await _repository.saveAppointment(
        doctorId: doctorId,
        patientId: id,
        date: date,
        time: time,
      );

      if (result.status.toLowerCase() == 'success') {
        await fetchAppointments(); // this sets loading=false at the end
      } else {
        _updateState(loading: false, error: "Booking failed");
      }
    } catch (e) {
      _updateState(loading: false, error: "Error: $e");
    }
  }
//used to cancel appointments
  Future<void> cancelAppointmentById(String id) async {
    _updateState(loading: true, error: null);
    try {
      final result = await _repository.cancelAppointment(appointmentId: id);
      if (result?.status.toLowerCase() == 'success') {
        _appointments.removeWhere((appt) => appt.id.toString() == id);
        _updateState(loading: false, data: _appointments);
      } else {
        _updateState(loading: false, error: "Cancellation failed");
      }
    } catch (e) {
      _updateState(loading: false, error: "Error: $e");
    }
  }

  void clearData() {
    _updateState(data: [], error: null, loading: false);
  }
}
