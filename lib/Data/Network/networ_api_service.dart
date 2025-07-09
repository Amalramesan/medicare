import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:med_care/data/Network/base_api_service.dart';
import 'package:med_care/data/response/app_excpetion.dart';
import 'package:med_care/Res/app_url.dart';
import 'package:med_care/view_model/services/store_auth_details.dart';

/// This class implements the BaseApiService and is responsible
/// for making HTTP requests (GET, POST, DELETE, Multipart upload)
/// with proper error handling, optional authorization, and token refresh logic.

class NetworApiService implements BaseApiService {
  @override
  Future<dynamic> getApi({
    required String endPoint,
    bool isAuth = false,
    String? getPayload,
  }) async {
    dynamic responseJson;
    try {
      final header = isAuth
          ? await _getHeaders(needAuth: isAuth)
          : _defaultHeaders;
      final url = getPayload == null ? endPoint : "$endPoint$getPayload/";

      final response = await http
          .get(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 30));

      responseJson = await returnResponse(
        response,
        () => getApi(endPoint: endPoint, isAuth: isAuth),
      );
    } on SocketException {
      throw FectchDataExpection('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future<dynamic> deleteApi({
    required String endPoint,
    bool isAuth = false,
    String? getPayload,
  }) async {
    final url = getPayload == null ? endPoint : "$endPoint$getPayload/";

    dynamic responseJson;
    try {
      final header = isAuth
          ? await _getHeaders(needAuth: isAuth)
          : _defaultHeaders;
      final response = await http
          .delete(Uri.parse(url), headers: header)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(
        response,
        () => deleteApi(endPoint: endPoint, isAuth: isAuth),
      );
    } on SocketException {
      throw FectchDataExpection('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApi({
    dynamic payload,
    required String endPoint,
    bool isAuth = false,
    int seconds = 30,
    String? getPayload,
  }) async {
    dynamic responseJson;

    try {
      final header = isAuth
          ? await _getHeaders(needAuth: isAuth)
          : _defaultHeaders;
      final url = getPayload == null ? endPoint : "$endPoint$getPayload/";

      final response = await http
          .post(Uri.parse(url), body: jsonEncode(payload), headers: header)
          .timeout(Duration(seconds: seconds));
      responseJson = returnResponse(
        response,
        () => postApi(payload: payload, endPoint: endPoint, isAuth: isAuth),
      );
    } on SocketException {
      throw FectchDataExpection('no internet connection');
    }

    return responseJson;
  }

  @override
  Future<dynamic> uploadMultipartFile({
    required String endPoint,
    required Map<String, String> fields,
    required File file,
    required String fileField,
    bool isAuth = true,
    String? mimeType,
  }) async {
    dynamic responseJson;

    try {
      final request = http.MultipartRequest('POST', Uri.parse(endPoint));

      // Add headers
      final header = isAuth
          ? await _getHeaders(needAuth: isAuth)
          : _defaultHeaders;
      request.headers.addAll(header);

      // Add file
      final multipartFile = await http.MultipartFile.fromPath(
        fileField,
        file.path,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      );
      request.files.add(multipartFile);

      // Add form fields
      request.fields.addAll(fields);

      // Send request
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      responseJson = await returnResponse(
        responseData,
        () => uploadMultipartFile(
          endPoint: endPoint,
          fields: fields,
          file: file,
          fileField: fileField,
          isAuth: isAuth,
          mimeType: mimeType,
        ),
      );
    } on SocketException {
      throw FectchDataExpection('No Internet Connection');
    }

    return responseJson;
  }

  //response
  dynamic returnResponse(
    http.Response response,
    Future<dynamic> Function() retryRequest,
  ) async {
    switch (response.statusCode) {
      case 200:
      case 201:
        final decoded = jsonDecode(response.body);
        log('200 success: $decoded');
        return decoded;

      case 400:
        final decoded = jsonDecode(response.body);
        log('400 error: $decoded');
        throw FectchDataExpection(decoded["message"]);

      case 401:
        if (await refreshToken()) {
          return await retryRequest();
        } else {
          throw FectchDataExpection("Unauthorized. Token refresh failed.");
        }

      case 404:
        final decoded = jsonDecode(response.body);
        log('404 error: $decoded');
        throw FectchDataExpection(decoded["message"]);

      default:
        log('Unknown error: ${response.body}');
        throw FectchDataExpection(
          'Error occurred while communicating with server [${response.statusCode}]',
        );
    }
  }

  //refresh tokens
  Future<bool> refreshToken() async {
    final storage = LocalStorageService();
    final refresh = storage.refreshToken;

    if (refresh == null) return false;

    try {
      final response = await http.post(
        Uri.parse("${AppUrl.base}/token-refresh/"),
        body: {'refresh': refresh},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        await storage.saveTokens(data['access'], data['refresh']);
        return true;
      }
    } catch (_) {
      return false;
    }

    await storage.clearTokens();
    return false;
  }

  //headers
  final Map<String, String> _defaultHeaders = {
    "SOURCE": "OWNER",
    "Language": "en",
    "Content-Type": "application/json",
  };

  Future<Map<String, String>> _getHeaders({bool needAuth = false}) async {
    final storage = LocalStorageService();
    await storage.init();
    Map<String, String> headers = Map.from(_defaultHeaders);

    if (needAuth) {
      final token = storage.accessToken;
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }
}
