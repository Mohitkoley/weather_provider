import 'package:flutter/material.dart';
import 'package:weather_app/utils/enums.dart';

extension ContextUtil on BuildContext {
  void snowSnackBar(String message,
      {SnackBarTypeEnum type = SnackBarTypeEnum.error}) async {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(message),
        backgroundColor: type.color,
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
      ),
    );
  }

  double get h => MediaQuery.sizeOf(this).height;

  double get w => MediaQuery.sizeOf(this).width;

  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!; //large
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!; // medium
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!; // small
}

extension EnumUtils on SnackBarTypeEnum {
  Color get color {
    switch (this) {
      case SnackBarTypeEnum.error:
        return Colors.red;
      case SnackBarTypeEnum.success:
        return Colors.green;
      case SnackBarTypeEnum.warning:
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
}
