import 'package:med_care/Data/response/status.dart';
///it is a class used to  represent the state of  an  api call(loading,success or error) 
class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;
  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.completed;

  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }
}
