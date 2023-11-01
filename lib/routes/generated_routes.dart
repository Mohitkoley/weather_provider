import 'package:flutter/material.dart';
import 'package:weather_app/routes/route_names.dart';
import 'package:weather_app/view/screens/weather_screen.dart';

class GeneratedRoutes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.weatherScreen:
        return MaterialPageRoute(
          builder: (_) => const WeatherScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
