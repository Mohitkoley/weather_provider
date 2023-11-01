import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/view_model/theme/theme_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(builder: (context, themeViewModel, _) {
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
    });
  }
}
