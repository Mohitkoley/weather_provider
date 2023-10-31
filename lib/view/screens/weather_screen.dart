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
      context.read<ThemeViewModel>().initSharedPref();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.weather,
        ),
        centerTitle: true,
      ),
      drawer: Consumer<ThemeViewModel>(builder: (context, themeViewModel, _) {
        return Drawer(
          width: context.w * 0.8,
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              DrawerHeader(
                child: Text(AppLocalizations.of(context)!.weather_application,
                    style: context.bodyMedium),
              ),
              SwitchListTile.adaptive(
                value: themeViewModel.isDark,
                onChanged: themeViewModel.toggleTheme,
                title: Text(
                    themeViewModel.isDark
                        ? AppLocalizations.of(context)!.dark_mode
                        : AppLocalizations.of(context)!.light_mode,
                    style: context.bodySmall),
              ),
              Container(
                //color: Colors.indigo,
                height: context.h * 0.08,
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        themeViewModel.changeLocale(context, "en");
                      },
                      child: Container(
                        width: context.w * 0.25,
                        decoration: BoxDecoration(
                          color: themeViewModel.isDark
                              ? Colors.deepPurple.withOpacity(0.4)
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "ENGLISH",
                          style: context.bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        themeViewModel.changeLocale(context, "hi");
                      },
                      child: Container(
                        width: context.w * 0.25,
                        decoration: BoxDecoration(
                          color: themeViewModel.isDark
                              ? Colors.deepPurple.withOpacity(0.4)
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "हिंदी",
                          style: context.bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      body: Consumer2<WeatherViewModel, ThemeViewModel>(
          builder: (context, weatherViewModel, theme, _) {
        switch (weatherViewModel.response.status) {
          case Status.loading:
            return const Center(
              child: CircularProgressIndicator(),
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
                    height: context.h * 0.2,
                    // color: Colors.grey,
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
                        SizedBox(
                          height: context.h * 0.02,
                        ),
                        Text(
                          weatherModel.timezone,
                          style: context.bodyMedium
                              .copyWith(fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: () {
                      return weatherViewModel.refresh(context);
                    },
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: theme.isDark
                                    ? Colors.purple.withOpacity(0.3)
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text(
                                //   "Feels like ${weatherModel.hourly[index].feelsLike}",
                                //   style: context.bodySmall,
                                // ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .feels_like,
                                      style: context.bodySmall.copyWith(
                                        fontSize: 14,
                                      )),
                                  TextSpan(
                                      text:
                                          "${weatherModel.hourly[index].feelsLike} °C",
                                      style: context.bodySmall.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic))
                                ])),
                                Text(
                                  "${weatherModel.hourly[index].temp} °C",
                                  style: context.bodyMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: context.h * 0.02,
                          );
                        },
                        itemCount: weatherModel.hourly.length),
                  )),
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
