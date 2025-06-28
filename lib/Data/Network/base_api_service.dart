abstract class BaseApiService{
  Future<dynamic>getGetApiResponse(String url);
  Future<dynamic>getPostApiResponse(String url,dynamic data);
   Future<dynamic> getDeleteApiResponse(String url, Map<String, String> headers); 
    Future<dynamic> getPatchApiResponse(String url, data) ;
}