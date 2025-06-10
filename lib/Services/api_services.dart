import 'dart:convert';

import 'package:med_care/Models/doctor_model.dart';
import 'package:med_care/Models/login_model.dart';
import 'package:med_care/Models/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:med_care/Models/time_slote_model.dart';

class ApiServices {
  final String baseUrl = "http://192.168.29.40:8000/";
  //registration
  Future<RegisterModel> registerUser(User user) async {
    final url = Uri.parse("http://192.168.29.40:8000/api/register/");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("regristration failed:${response.body}");
    }
  }

  //login
  Future<LoginModel> loginuser(String email, String password) async {
    final url = Uri.parse("http://192.168.29.40:8000/api/login/");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("login failed: ${response.body}");
    }
  }

  //doctors list
  Future<List<DoctorModel>> fetchDoctors() async {
    final response = await http.get(
      Uri.parse('http://192.168.29.40:8000/api/doctors/'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<DoctorModel> doctors = body
          .map((item) => DoctorModel.fromJson(item))
          .toList();

      return doctors;
    } else {
      throw Exception("Failed to load doctors: ${response.body}");
    }
  }

  //fetch doctor by list
  Future<List<DoctorModel>> fetchDoctorBytime(String date) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.29.40:8000/api/doctors/?date=$date'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Debug: see the API response format
        print('Doctor API response: ${response.body}');

        final jsonData = jsonDecode(response.body);

        // Check if API returns a list or an object
        List<dynamic> body;

        if (jsonData is List) {
          // API returned a List []
          body = jsonData;
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          // API returned an object with a "data" field
          body = jsonData['data'];
        } else {
          throw Exception('Unexpected API format');
        }

        return body.map((item) => DoctorModel.fromJson(item)).toList();
      } else {
        throw Exception(
          'Failed to load doctors for date $date. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching doctors: $e');
    }
  }

  //timeslots
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
}
