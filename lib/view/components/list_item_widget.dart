import 'package:flutter/material.dart';
import 'package:weather_app/utils/export.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    super.key,
    required this.current,
    required this.theme,
  });

  final Current current;
  final ThemeViewModel theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color:
              theme.isDark ? Colors.purple.withOpacity(0.3) : Colors.grey[300],
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
                text: AppLocalizations.of(context)!.feels_like,
                style: context.bodySmall.copyWith(
                  fontSize: 14,
                )),
            TextSpan(
                text: "${current.feelsLike} °C",
                style: context.bodySmall.copyWith(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic))
          ])),
          Text(
            "${current.temp} °C",
            style: context.bodyMedium.copyWith(
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
