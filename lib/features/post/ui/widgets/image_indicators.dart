import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class ImageIndicators extends StatelessWidget {
  final int length;
  final int currentIndex;
  const ImageIndicators({
    super.key,
    required this.length,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4.h,
        horizontal: 8.w,
      ),
      decoration: BoxDecoration(
        color: ColorsManager.gray.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        '${currentIndex + 1} / $length',
        style: TextStyles.font12Bold.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
