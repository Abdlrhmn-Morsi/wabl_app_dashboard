import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/extensions.dart';
import '../helpers/spacing.dart';
import '../theming/styles.dart';
import 'app_text_button.dart';

class AppMessage {
  static Future show({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                verticalSpace(10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyles.font14Medium.copyWith(
                    color: isError ? Colors.red : null,
                  ),
                ),
                verticalSpace(10),
                AppTextButton(
                  buttonText: 'ok',
                  buttonHeight: 25,
                  textStyle: TextStyles.font12Bold,
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
