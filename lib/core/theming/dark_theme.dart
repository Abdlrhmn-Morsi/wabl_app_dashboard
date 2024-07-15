import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData dark() => ThemeData(
      useMaterial3: false,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        },
      ),
      scaffoldBackgroundColor: Colors.black,
      primaryColor: ColorsManager.mainColor,
      brightness: Brightness.dark,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        refreshBackgroundColor: ColorsManager.mainBoldColor,
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        //
        inversePrimary: ColorsManager.mainBoldColor,
        //
        primary: Colors.white,
        onPrimary: Colors.white,
        //
        secondary: ColorsManager.black,
        onSecondary: Colors.white,
        //
        background: Colors.white,
        onBackground: ColorsManager.black,
        //
        error: Colors.red,
        onError: Colors.red,
        //
        surface: Colors.black,
        onSurface: Colors.white,
      ),
    );
