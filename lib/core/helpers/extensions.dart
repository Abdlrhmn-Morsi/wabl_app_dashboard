import 'package:flutter/material.dart';
import '../routing/screen_argument.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {ScreenArgument? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(
    String routeName, {
    ScreenArgument? arguments,
  }) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushAndReplaceAllNamed(
    String routeName, {
    ScreenArgument? arguments,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  void pop() => Navigator.of(this).pop();
}

extension XNavigate on Widget {
  Future goOnWidget(context) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => this,
        ),
      );

  Future goAndReplaceAllOnWidget(context) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => this),
      (route) => false,
    );
  }

  Future goAndReplaceOnWidget(context, {Object? arguments}) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => this),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
