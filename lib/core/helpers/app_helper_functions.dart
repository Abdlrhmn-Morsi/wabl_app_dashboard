import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';

class AppHelperFunctions {
  static Map<String, dynamic> removeNulls(Map<String, dynamic> data) {
    return data..removeWhere((key, value) => value == null);
  }

  static double converStringToDouble(String value) {
    double reselt = 0.0;
    try {
      reselt = double.parse(value);
    } catch (e) {
      reselt = 0.0;
    }
    return reselt;
  }

  static int converStringToInt(String value) {
    int reselt = 0;
    try {
      reselt = int.parse(value);
    } catch (e) {
      reselt = 0;
    }
    return reselt;
  }

  static Color getVarientColor(String color) {
    Color colorCode = Colors.transparent;
    try {
      var parsedColor = int.parse('0xff${color.replaceAll('#', '')}');
      colorCode = Color(parsedColor);
    } catch (e) {
      colorCode = Colors.transparent;
    }
    return colorCode;
  }

  static String formatedDate(
    DateTime? dateTime, {
    String? dateFormatPattern,
  }) {
    return intl.DateFormat(dateFormatPattern ?? 'yyyy-MM-dd HH:mm:ss a').format(
      dateTime ?? DateTime.now(),
    );
  }

  static String formatNumber(int number) {
    return NumberFormat.compact().format(number);
  }

  static unFocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
