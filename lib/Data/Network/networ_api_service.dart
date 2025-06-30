import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:med_care/data/Network/base_api_service.dart';
import 'package:med_care/data/Response/app_excpetion.dart';
import 'package:http/http.dart' as http;

class NetworkApiService implements BaseApiService {
  @override
  Future<dynamic> getGetApiResponse(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 40));
      return returnResponse(response);
    } on SocketException {
      throw FectchDataExpection('No internet connection');
    }
  }

  @override
  Future<dynamic> getPostApiResponse(
    String url,
    dynamic data, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: headers ?? {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));
      return returnResponse(response);
    } on SocketException {
      throw FectchDataExpection('No internet connection');
    }
  }

  @override
  Future<dynamic> getDeleteApiResponse(
    String url,
    Map<String, String> headers,
  ) async {
    try {
      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      return returnResponse(response);
    } on SocketException {
      throw FectchDataExpection('No internet connection');
    }
  }

  @override
  Future<dynamic> getPatchApiResponse(String url, data) {
    throw UnimplementedError('PATCH API not implemented yet');
  }

  // Upload file using multipart/form-data
  Future<dynamic> uploadMultipartFile({
    required String url,
    required Map<String, String> fields,
    required File file,
    required String token,
    required String fileField,
    String mimeType = 'application/pdf',
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer $token'
        ..fields.addAll(fields)
        ..files.add(
          await http.MultipartFile.fromPath(
            fileField,
            file.path,
            contentType: MediaType.parse(mimeType),
          ),
        );

      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      if (streamedResponse.statusCode == 200 ||
          streamedResponse.statusCode == 201) {
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

  // Response handler
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
          'Error occurred during communication with server. Status code: ${response.statusCode}',
        );
    }
  }
}
