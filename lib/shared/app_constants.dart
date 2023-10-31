class AppConstants {
  static String _appId = "";
  static String get appId => _appId;

  static setAppId(String appId) {
    _appId = appId;
  }

  static const lat = "22.5726";
  static const lon = "88.3639";
  static const lang = "en";
  static const units = "metric";

  //theme bool
  static const String isDarkMode = "isDarkMode";

  //weather data
  static const String weatherData = "weatherData";
}
