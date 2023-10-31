import 'package:weather_app/data/api_endpoints.dart';
import 'package:weather_app/data/network/base_api_services.dart';
import 'package:weather_app/data/network/network_api_service.dart';

class WeatherRepository {
  BaseApiServices _baseApiServices = NetworkApiService();

  Future<dynamic> getWeather(Map<String, dynamic> parameter) async {
    try {
      dynamic response =
          _baseApiServices.getGetApiResponse(ApiEndPoint.data, parameter);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
