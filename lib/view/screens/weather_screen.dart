import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/response/status.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/shared/widgets/drawer/drawer_widget.dart';
import 'package:weather_app/shared/widgets/error_screen.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/view/components/list_item_widget.dart';
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
      drawer: DrawerWidget(),
      body: Consumer2<WeatherViewModel, ThemeViewModel>(
          builder: (context, weatherViewModel, theme, _) {
        switch (weatherViewModel.response.status) {
          case Status.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case Status.error:
            return ErrorScreen(errorText: weatherViewModel.response.message!);
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
                          Current current = weatherModel.hourly[index];
                          return ListItemWidget(
                            current: current,
                            theme: theme,
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
