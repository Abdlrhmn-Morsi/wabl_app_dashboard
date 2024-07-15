import 'package:flutter/material.dart';

class AppSize {
  static double fullWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double fullHight(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
