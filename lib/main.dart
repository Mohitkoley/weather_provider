import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/env/api_key.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/routes/generated_routes.dart';
import 'package:weather_app/routes/route_names.dart';
import 'package:weather_app/shared/widgets/error_screen.dart';
import 'package:weather_app/view/screens/home_screen.dart';
import 'package:weather_app/view/screens/weather_screen.dart';
import 'package:weather_app/view_model/Theme/theme_view_model.dart';
import 'package:weather_app/view_model/weather_view_model.dart';

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await ApiKey().loadApiKey();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return Scaffold(
      body: ErrorScreen(
        errorText: errorDetails.exceptionAsString(),
      ),
    );
  };
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => WeatherViewModel()),
      ChangeNotifierProvider(create: (_) => ThemeViewModel()),
    ],
    builder: (context, child) {
      return const MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(builder: (context, theme, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: theme.themeData,
        // theme: ThemeData.light(),
        initialRoute: RouteNames.homeScreen,
        onGenerateRoute: GeneratedRoutes.generateRoute,
      );
    });
  }
}
