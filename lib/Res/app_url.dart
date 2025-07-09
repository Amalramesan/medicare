
/// This class holds all the API endpoint URLs used in the application.
///It centralizes API paths to make maintenance easier and reduce hardcoded strings across the app.
class AppUrl {
  static const String base = 'http://10.0.2.2:8000/';

  // register and login Endpoints
  static const String register = "$base/api/register/";
  static const String login = "$base/api/login/";

  // Doctor Endpoints
  static const String doctors = "$base/api/doctors/";
  static String doctorAvailability(String doctorId, String date) =>
      "$base/api/doctor/$doctorId/availability?date=$date";
  //time slots
  static String fetchTimeSlots(String doctorId, String date) =>
      "$base/api/doctor/$doctorId/timeslots?date=$date";

  //appointments
  static const String bookAppointment = "$base/api/book-appointment/";
  //appointment history
  static const String appointmentHistory = "$base/api/appointments/history/";
  //upload document
  static const String uploadDocument = "$base/api/upload-report/";
  //fetchdocument
  static const String fetchDocument = "$base/api/my-reports/";
  //profile
  static const String profile = "$base/api/profile/";
  //appointment cancel
  static appointmentCancel(String appointmentId) =>
      "$base/api/appointment/$appointmentId/cancel/";
  //logout
  static const String logoutt = "$base/api/logout/";
}
