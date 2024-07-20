import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors.dart';

class AddOrEditBtn extends StatelessWidget {
  final void Function()? onTap;
  final IconData icon;
  const AddOrEditBtn({
    super.key,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColorsTheme.adaptiveShadow(context),
              spreadRadius: 3,
              blurRadius: 3,
            ),
          ],
          shape: BoxShape.circle,
          color: ColorsManager.mainColor,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 35.sp,
        ),
      ),
    );
  }
}
