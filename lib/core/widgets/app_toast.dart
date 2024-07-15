import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';

class AppToast {
  static show({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    return showToast(
      message,
      context: context,
      backgroundColor: isError ? Colors.red : ColorsManager.mainColor,
      textStyle: TextStyles.font12Medium.copyWith(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
      animation: StyledToastAnimation.slideToBottomFade,
    );
  }
}
