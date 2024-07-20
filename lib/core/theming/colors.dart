import 'package:flutter/material.dart';

class ColorsManager {
  static const Color mainColor = Color(0xFF316FF6);
  static const Color mainBoldColor = Color(0xFF3b5998);
  static const Color mainSemiBoldColor = Color(0xFF8b9dc3);
  static const Color mainSemiLightColor = Color(0xFFdfe3ee);

  static const Color secondaryColor = Color(0xFfFF7F3E);
  static const Color thirdColor = Color(0xFF4169E1);
  //?---------------------------------------------------------
  static const Color gray = Color(0xFF757575);
  static const Color lightGray = Color(0xFFCCCCCC);
  static const Color lighterGray = Color(0xffF5F5F0);
  static const Color black = Color.fromARGB(255, 32, 32, 32);
}

//  final brightness = MediaQuery.platformBrightnessOf(context);
//     final systemDarkMode = brightness == Brightness.dark;
class AppColorsTheme {
  static bool isDarkMode({required BuildContext context}) {
    Brightness brightness = Theme.of(context).brightness;
    bool darkModeOn = brightness == Brightness.dark;
    return darkModeOn;
  }

  static Color blackAndWhite(BuildContext context) {
    return isDarkMode(context: context) ? Colors.black : Colors.white;
  }

  static Color messageBgSender(BuildContext context) {
    return isDarkMode(context: context)
        ? Colors.grey.shade900
        : Colors.grey.shade100;
  }

  static Color messageBgReciver(BuildContext context) {
    return isDarkMode(context: context)
        ? const Color(0xff005C4B)
        : const Color(0xFF009176);
  }

  static Color blackAndWhiteSwitch(BuildContext context) {
    return isDarkMode(context: context) ? Colors.white : Colors.black;
  }

  static Color onBackground(BuildContext context) {
    return Theme.of(context).colorScheme.onBackground;
  }

  static Color adaptiveShadow(BuildContext context) {
    return isDarkMode(context: context)
        ? Colors.white.withOpacity(.4)
        : Colors.black.withOpacity(.1);
  }

  static Color adaptiveGray(BuildContext context) {
    return isDarkMode(context: context)
        ? Colors.grey.shade900
        : ColorsManager.lighterGray;
  }
}
