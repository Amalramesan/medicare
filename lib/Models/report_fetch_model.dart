class ReportFetchModel {
  ReportFetchModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });
  late final String status;
  late final int statusCode;
  late final String message;
  late final List<Data> data;

  ReportFetchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final datas = <String, dynamic>{};
    datas['status'] = status;
    datas['status_code'] = statusCode;
    datas['message'] = message;
    datas['data'] = data.map((e) => e.toJson()).toList();
    return datas;
  }
}

class Data {
  Data({
    required this.id,
    required this.document,
    required this.report,
    required this.description,
    required this.uploadedAt,
  });
  late final int id;
  late final String document;
  late final String report;
  late final String description;
  late final String uploadedAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    document = json['document'];
    report = json['report'];
    description = json['description'];
    uploadedAt = json['uploaded_at'];
  }

  Map<String, dynamic> toJson() {
    final datass = <String, dynamic>{};
    datass['id'] = id;
    datass['document'] = document;
    datass['report'] = report;
    datass['description'] = description;
    datass['uploaded_at'] = uploadedAt;
    return datass;
  }
}
