import 'dart:convert';
import 'dart:io';
import 'package:med_care/Models/appointment_history_model.dart';
import 'package:med_care/Models/appointment_model.dart';
import 'package:med_care/Models/doctor_model.dart';
import 'package:med_care/Models/login_model.dart';
import 'package:med_care/Models/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:med_care/Models/report_fetch_model.dart';
import 'package:med_care/Models/time_slote_model.dart';
import 'package:med_care/Models/upload_model.dart';
import 'package:med_care/utilities/tokens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class ApiServices {
  final String baseUrl = "http://192.168.29.40:8000/";

  // registration

  Future<RegisterModel> registerUser(User user) async {
    final url = Uri.parse("http://192.168.29.40:8000/api/register/");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final registerModel = RegisterModel.fromJson(jsonDecode(response.body));
      final userData = registerModel.data;

      // Save user data into SharedPreferences
      await saveRegisteredUser(
        name: userData.name,
        email: userData.email,
        place: userData.place,
        phoneNumber: userData.phoneNumber,
      );

      return registerModel;
    } else {
      throw Exception("Registration failed: ${response.body}");
    }
  }

  Future<LoginModel> loginuser(String email, String password) async {
    final url = Uri.parse("http://192.168.29.40:8000/api/login/");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> rawJson = jsonDecode(response.body);

      final loginModel = LoginModel.fromJson(rawJson);

      final access = loginModel.data.access;
      final refresh = loginModel.data.refresh;
      final user = loginModel.data.user;

      await saveTokens(access, refresh);
      await saveUserName(user.email);
      await savePatientId(user.id);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', access);

      return loginModel;
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }

  // fetch all the doctors
  Future<List<DoctorModel>> fetchDoctors() async {
    final response = await http.get(
      Uri.parse('http://192.168.29.40:8000/api/doctors/'),
    );
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => DoctorModel.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load doctors");
    }
  }

  // check if doctor is available for a selected date
  Future<bool> isDoctorAvailable(String doctorId, String date) async {
    final response = await http.get(
      Uri.parse(
        'http://192.168.29.40:8000/api/doctor/$doctorId/availability?date=$date',
      ),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = json["data"];
      return data is List && data.isNotEmpty;
    } else {
      return false;
    }
  }

  // timeslots
  Future<TimeSlots> fetchTimeSlots(String doctorId, String date) async {
    final url = Uri.parse(
      'http://192.168.29.40:8000/api/doctor/$doctorId/timeslots?date=$date',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print("TimeSlots API Response: $jsonData");
      return TimeSlots.fromJson(jsonData);
    } else {
      throw Exception(
        'Failed to load time slots. Status code: ${response.statusCode}',
      );
    }
  }

  // appointment booking
  Future<AppointmentBooking> saveAppointment({
    required int doctorId,
    required int patientId,
    required String date,
    required String time,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Authentication token not found');
    }

    final response = await http.post(
      Uri.parse('http://192.168.29.40:8000/api/book-appointment/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "doctor": doctorId,
        'patient_id': patientId,
        'date': date,
        'time': time,
      }),
    );

    if (response.statusCode == 201) {
      return AppointmentBooking.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to save appointments: ${response.body}');
    }
  }

  //appointment history
  static Future<List<AppointmentHistoryModel>> fetchPatientAppointments(
    int patientId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    final url = Uri.parse(
      'http://192.168.29.40:8000/api/appointments/history/',
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print(' Status code: ${response.statusCode}');
    print(' Response body: ${response.body}');

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      if (decoded is List) {
        // Response is a plain list
        return decoded
            .map<AppointmentHistoryModel>(
              (e) => AppointmentHistoryModel.fromJson(e),
            )
            .toList();
      } else if (decoded is Map && decoded.containsKey('data')) {
        // Response is a map with 'data' key
        final List jsonData = decoded['data'];
        return jsonData
            .map<AppointmentHistoryModel>(
              (e) => AppointmentHistoryModel.fromJson(e),
            )
            .toList();
      } else {
        throw Exception(" Unexpected response format: $decoded");
      }
    } else {
      throw Exception(
        'Failed to load appointment history (Status: ${response.statusCode})',
      );
    }
  }

  // upload document
  static Future<UploadModel?> uploadDocuments({
    required File documentFile,
    required String report,
    required String description,
    required int patientId,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('access_token');
    final patientId = prefs.getInt('patient_id');

    if (token == null || patientId == null) {
      throw Exception('Authentication or Patient ID not found');
    }

    var uri = Uri.parse("http://192.168.29.40:8000/api/upload-report/");

    var request = http.MultipartRequest("POST", uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['report'] = report
      ..fields['description'] = description
      ..fields['patient_id'] = patientId.toString()
      ..files.add(
        await http.MultipartFile.fromPath(
          'document',
          documentFile.path,
          contentType: MediaType('application', 'pdf'),
        ),
      );

    var streamedResponse = await request.send();
    final responseBody = await streamedResponse.stream.bytesToString();

    print('Status Code: ${streamedResponse.statusCode}');
    print('Response Body: $responseBody');

    if (streamedResponse.statusCode == 200 ||
        streamedResponse.statusCode == 201) {
      return UploadModel.fromJson(json.decode(responseBody));
    } else {
      print("Upload failed ");
      return null;
    }
  }

  //fetch document
  static Future<ReportFetchModel?> fetchReports() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final url = Uri.parse("http://192.168.29.40:8000/api/my-reports/");
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return ReportFetchModel.fromJson(json.decode(response.body));
    } else {
      print("Error fetching reports:${response.body}");
      return null;
    }
  }
}
