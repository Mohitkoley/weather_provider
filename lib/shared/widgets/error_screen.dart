import 'package:flutter/material.dart';
import 'package:weather_app/utils/enums.dart';
import 'package:weather_app/utils/utils.dart';

class ErrorScreen extends StatelessWidget {
  final String errorText;

  const ErrorScreen({Key? key, required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SelectableText(
        errorText,
        onTap: () {
          // you can show toast to the user, like "Copied"
          context.snowSnackBar("Copied", type: SnackBarTypeEnum.success);
        },
      ),
    );
  }
}
