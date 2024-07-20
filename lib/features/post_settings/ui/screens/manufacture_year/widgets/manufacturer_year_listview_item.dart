import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/helpers/spacing.dart';
import 'package:wabl_app_dashboard/core/theming/colors.dart';
import '../../../../../../core/helpers/app_images.dart';
import '../../../../../../core/theming/styles.dart';
import '../../../../data/manufacture_year_model.dart';

class ManufacturerYearListviewItem extends StatelessWidget {
  final ManufactureYearModel manufactureYear;
  final void Function()? onTap;
  const ManufacturerYearListviewItem({
    super.key,
    this.onTap,
    required this.manufactureYear,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColorsTheme.blackAndWhite(context),
            boxShadow: [
              BoxShadow(
                color: AppColorsTheme.adaptiveShadow(context),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ]),
        child: Row(
          children: [
            Image.asset(
              AppImages.calendar,
              height: 22.h,
            ),
            horizontalSpace(10),
            Text(
              manufactureYear.year ?? "",
              style: TextStyles.font14Bold,
            ),
          ],
        ),
      ),
    );
  }
}
