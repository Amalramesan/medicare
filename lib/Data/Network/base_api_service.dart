abstract class BaseApiService{
  Future<dynamic>getGetApiResponse(String url, {required Map<String, String> headers});
  Future<dynamic>getPostApiResponse(String url,dynamic data, {required Map<String, String> headers});
   Future<dynamic> getDeleteApiResponse(String url, Map<String, String> headers); 
    Future<dynamic> getPatchApiResponse(String url, data) ;
}