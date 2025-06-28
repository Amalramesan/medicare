
import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:med_care/Data/Network/base_api_service.dart';
import 'package:med_care/Data/Response/app_excpetion.dart';
import 'package:http/http.dart' as http;

class NetworkApiService implements BaseApiService {
  @override
  Future getGetApiResponse(String url, {Map<String, String>? headers})  async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
      ).timeout(const Duration(seconds: 40));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FectchDataExpection('No internet Connection');
    }
    return responseJson;
  }
  @override
Future getPostApiResponse(String url, dynamic data, {Map<String, String>? headers}) async {
  dynamic responseJson;

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: headers ?? {'Content-Type': 'application/json'}, // fallback to default
      body: jsonEncode(data),
    ).timeout(const Duration(seconds: 10));

    responseJson = returnResponse(response);
  } on SocketException {
    throw FectchDataExpection('No internet Connection');
  }

  return responseJson;
}

  
  Future getPatchApiResponse(String url, data) {
    throw UnimplementedError();
  }
  Future getDeleteApiResponse(String url, Map<String, String> headers) async {
  dynamic responseJson;
  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
    ).timeout(const Duration(seconds: 10));
    responseJson = returnResponse(response);
  } on SocketException {
    throw FectchDataExpection('No internet connection');
  }
  return responseJson;
}
// handle multipart file uploads
Future<dynamic> uploadMultipartFile({
  required String url,
  required Map<String, String> fields,
  required File file,
  required String token,
  required String fileField,
  String mimeType = 'application/pdf',
}) async {
  try {
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields.addAll(fields)
      ..files.add(
        await http.MultipartFile.fromPath(
          fileField,
          file.path,
          contentType: MediaType('application', 'pdf'),
        ),
      );

    final streamedResponse = await request.send();
    final responseBody = await streamedResponse.stream.bytesToString();

    if (streamedResponse.statusCode == 200 || streamedResponse.statusCode == 201) {
      return jsonDecode(responseBody);
    } else {
      throw FectchDataExpection(
        'Upload failed with status code: ${streamedResponse.statusCode}, body: $responseBody',
      );
    }
  } on SocketException {
    throw FectchDataExpection('No internet connection');
  }
}


  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestExpection(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedExpection(response.body.toString());
      case 404:
        throw FectchDataExpection('Resource not found');
      default:
        throw FectchDataExpection(
          'Error occurred during communication with server '
          'with status code: ${response.statusCode}',
        );
    }
  }
  
 
}
