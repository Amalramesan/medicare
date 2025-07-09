import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:med_care/Models/report_fetch_model.dart';
import 'package:med_care/data/response/api_response.dart';
import 'package:med_care/repository/documents_resporitay.dart';
import 'package:med_care/view_model/services/store_auth_details.dart';

class ReportFetchController with ChangeNotifier {
  //this controller is used for fetching the reports that is alredy stored in the backend
  ReportFetchController(){
    loadReports();
  }
  final _repository = DocumentRepository();
  final _storage = LocalStorageService();
  ApiResponse<List<Data>> _reportsResponse = ApiResponse.loading();
  ApiResponse<List<Data>> get reportsResponse=>_reportsResponse;
  String _error="";
  String get error=>_error;
  void _setError(String error){
    _error=error;
    notifyListeners();
  }
  void _setReportsResponse(ApiResponse<List<Data>>response){
    _reportsResponse=response;
    notifyListeners();
  }
   Future<void>loadReports()async{
    _setError("");
    _setReportsResponse(ApiResponse.loading());
    try{
      await _storage.init();
      final patientId=_storage.patientId;
      if(patientId==null){
        _setError("Patient id not found");
        _setReportsResponse(ApiResponse.error("missing patient id"));
        return;
      }
      final ReportFetchModel?result=await _repository.fetchReports(patientId: patientId.toString());
      if(result!=null && result.data.isNotEmpty){
        _setReportsResponse(ApiResponse.completed(result.data));
      }else{
        _setError("no report found");
        _setReportsResponse(ApiResponse.error("empty report list"));
      }
    }catch(e){
      log("error fetching reports:$e");
      _setError("something went wrong");
      _setReportsResponse(ApiResponse.error(e.toString()));
    }  
   }
}
