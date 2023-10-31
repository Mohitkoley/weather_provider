import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/response/status.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/shared/widgets/error_screen.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/view_model/theme/theme_view_model.dart';
import 'package:weather_app/view_model/weather_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        centerTitle: true,
      ),
      drawer: ChangeNotifierProvider(
        create: (_) => ThemeViewModel(),
        child: Consumer<ThemeViewModel>(builder: (context, themeViewModel, _) {
          return Drawer(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                DrawerHeader(
                  child: Text("Weather Application", style: context.bodyMedium),
                ),
                SwitchListTile.adaptive(
                  value: themeViewModel.isDark,
                  onChanged: themeViewModel.toggleTheme,
                  title: Text(
                      themeViewModel.isDark ? "Dark Mode" : "Light Mode",
                      style: context.bodySmall),
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
            WeatherModel weatherModel = weatherViewModel.response.data!;
            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: context.w,
                    margin: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.current,
                          style: context.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: context.h * 0.02,
                        ),
                        Text(
                          "${weatherModel.current.temp} °C",
                          style: context.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
