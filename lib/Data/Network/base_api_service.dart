import 'dart:io';

/// An abstract class that defines the contract for all API service implementations.
/// It includes standard HTTP operations such as GET, POST, DELETE,
/// and file upload with multipart/form-data.
abstract class BaseApiService {
  Future<dynamic> getApi({
    required String endPoint,
    bool isAuth = false,
    String? getPayload,
  });

  Future<dynamic> postApi({
    required dynamic payload,
    required String endPoint,
    bool isAuth = false,
    int seconds = 10,
    String? getPayload,
  });

  Future<dynamic> deleteApi({
    required String endPoint,
    bool isAuth = false,
    String? getPayload,
  });

  Future<dynamic> uploadMultipartFile({
    required String endPoint,
    required Map<String, String> fields,
    required File file,
    required String fileField,
    bool isAuth = true,
    String? mimeType,
  });
}
