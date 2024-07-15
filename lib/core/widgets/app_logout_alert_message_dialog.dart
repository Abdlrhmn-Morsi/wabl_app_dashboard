import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/app_size.dart';
import '../helpers/extensions.dart';
import '../helpers/spacing.dart';
import '../theming/styles.dart';

class AppLogoutAlertMessage {
  static Future<Object?> show({
    required BuildContext context,
    required String message,
    required Function onSubbmit,
  }) {
    return showGeneralDialog(
      barrierDismissible: false,
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container();
      },
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Container(
                width: AppSize.fullWidth(context) * .5,
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
                      style: TextStyles.font16Medium.copyWith(),
                    ),
                    verticalSpace(10),
                    const Divider(),
                    verticalSpace(5),
                    GestureDetector(
                      onTap: () {
                        onSubbmit();
                      },
                      child: Text(
                        'Log out',
                        style: TextStyles.font14Bold.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    verticalSpace(5),
                    const Divider(),
                    verticalSpace(5),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyles.font14Bold,
                      ),
                    ),
                    verticalSpace(5),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
