import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';

class AppLoading {
  static loading(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 5.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.sp),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'loading',
                  style: TextStyles.font14Medium.copyWith(
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  width: 25.w,
                ),
                SizedBox(
                  height: 20.w,
                  width: 20.w,
                  child: CircularProgressIndicator(
                    color: ColorsManager.mainBoldColor,
                    strokeWidth: 2.sp,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
