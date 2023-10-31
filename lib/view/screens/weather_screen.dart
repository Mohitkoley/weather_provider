import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/response/status.dart';
import 'package:weather_app/shared/widgets/error_screen.dart';
import 'package:weather_app/view_model/theme/theme_view_model.dart';
import 'package:weather_app/view_model/weather_view_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<WeatherViewModel>().localOrApiData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather",
        ),
      ),
      drawer: ChangeNotifierProvider(
        create: (_) => ThemeViewModel(),
        child: Consumer<ThemeViewModel>(builder: (context, themeViewModel, _) {
          return Drawer(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                const DrawerHeader(
                  child: Text("Weather Application"),
                ),
                Switch(
                  value: themeViewModel.isDark,
                  onChanged: themeViewModel.toggleTheme,
                )
              ],
            ),
          );
        }),
      ),
      body: Consumer<WeatherViewModel>(builder: (context, weatherViewModel, _) {
        switch (weatherViewModel.response.status) {
          case Status.loading:
            return const Center(
              child: const CircularProgressIndicator(),
            );
          case Status.error:
            return const ErrorScreen(errorText: "Something went wrong");
          case Status.completed:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weatherViewModel.response.data!.timezone.toString(),
                ),
              ],
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      }),
    );
  }
}
