import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData light() => ThemeData(
      useMaterial3: false,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        },
      ),
      primaryColor: ColorsManager.mainColor,
      scaffoldBackgroundColor: Colors.white,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        refreshBackgroundColor: ColorsManager.mainBoldColor,
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.black,
        onPrimary: Colors.black,
        //
        secondary: Colors.white,
        onSecondary: Colors.white,
        //
        error: Colors.red,
        onError: Colors.red,
        background: Colors.black,
        onBackground: ColorsManager.lighterGray,
        surface: Colors.white,

        onSurface: Colors.black,
        //
      ).copyWith(background: Colors.white),
    );
