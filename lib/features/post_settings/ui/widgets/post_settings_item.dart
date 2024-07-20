import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/theming/colors.dart';
import '../../../../core/helpers/app_size.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';

class PostSettingsItem extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const PostSettingsItem({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppSize.fullWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColorsTheme.blackAndWhite(context),
          boxShadow: [
            BoxShadow(
              color: AppColorsTheme.adaptiveShadow(context),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.settings,
              size: 25.sp,
              color: ColorsManager.mainBoldColor,
            ),
            horizontalSpace(10),
            Text(
              title,
              style: TextStyles.font16Medium,
            ),
          ],
        ),
      ),
    );
  }
}
