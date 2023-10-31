import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:weather_app/data/response/api_response.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/shared_prefrenced/shared_prefrence_service.dart';
import 'package:weather_app/shared/app_constants.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository _repo = WeatherRepository();
  Map<String, dynamic> params = {
    "lat": AppConstants.lat,
    'lon': AppConstants.lon,
    'lang': AppConstants.lang,
    'units': AppConstants.units,
  };

  SharedPreferenceService _sp = SharedPreferenceService();

  ApiResponse<WeatherModel> _response = ApiResponse.loading();

  ApiResponse<WeatherModel> get response => _response;

  setStatus(ApiResponse<WeatherModel> status) {
    _response = status;
    notifyListeners();
  }

  Future getWeather(BuildContext context) async {
    setStatus(ApiResponse.loading());
    await _repo.getWeather(params).then((value) {
      log(value.toString());
      WeatherModel model = WeatherModel.fromJson(value);
      _sp.saveString(AppConstants.weatherData, weatherModelToJson(model));
      setStatus(ApiResponse.completed(model));
    }).catchError((e) {
      setStatus(ApiResponse.error(e.toString()));
    });
  }

  Future refresh(BuildContext context) async {
    await getWeather(context);
  }

  localOrApiData(BuildContext context) async {
    setStatus(ApiResponse.loading());
    String? data = await _sp.getString(AppConstants.weatherData);
    if (data == null) {
      if (context.mounted) {
        await getWeather(context);
      }
    } else {
      WeatherModel model = weatherModelFromJson(data);
      setStatus(ApiResponse.completed(model));
    }
  }
}
