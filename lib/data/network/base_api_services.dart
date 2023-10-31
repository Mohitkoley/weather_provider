import 'dart:io';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(
      String path, Map<String, dynamic> queryParameter);

  Future<dynamic> getPostApiResponse(String url, dynamic data);

  Future<dynamic> getPutApiResponse(
    String url,
    dynamic data,
  );

  Future<dynamic> getDeleteApiResponse(
    String url,
    dynamic data,
  );

  Future<dynamic> getPostMultiPartApiResponse(
      String url, Map<String, String> data, File image);
}
