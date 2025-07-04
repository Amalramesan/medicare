class ReportFetchModel {
  final String status;
  final int statusCode;
  final String message;
  final List<Data> data;

  ReportFetchModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ReportFetchModel.fromJson(Map<String, dynamic> json) {
    return ReportFetchModel(
      status: json['status'] ?? '',
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'status_code': statusCode,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Data {
  final int id;
  final String document;
  final String report;
  final String description;
  final String uploadedAt;

  Data({
    required this.id,
    required this.document,
    required this.report,
    required this.description,
    required this.uploadedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] ?? 0,
      document: json['document'] ?? '',
      report: json['report'] ?? '',
      description: json['description'] ?? '',
      uploadedAt: json['uploaded_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'document': document,
      'report': report,
      'description': description,
      'uploaded_at': uploadedAt,
    };
  }
}
