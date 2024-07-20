import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class AppPostTag extends StatelessWidget {
  final String name;
  final String title;
  final Color? color;
  const AppPostTag({
    super.key,
    required this.title,
    required this.name,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.sp),
      decoration: BoxDecoration(
        color: color ?? ColorsManager.mainColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyles.font12Bold.copyWith(
              color: Colors.white,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            height: 10.h,
            width: 1.5.w,
            color: Colors.white,
          ),
          Text(
            name,
            style: TextStyles.font10Bold.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
