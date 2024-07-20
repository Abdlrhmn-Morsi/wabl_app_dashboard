import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/helpers/app_images.dart';
import 'package:wabl_app_dashboard/core/helpers/spacing.dart';
import 'package:wabl_app_dashboard/core/theming/colors.dart';
import 'package:wabl_app_dashboard/features/post_settings/data/car_type_model.dart';
import '../../../../../../core/theming/styles.dart';

class CarTypeListviewItem extends StatelessWidget {
  final CarTypeModel carTyp;
  final void Function()? onTap;
  const CarTypeListviewItem({
    super.key,
    this.onTap,
    required this.carTyp,
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
              AppImages.car,
              height: 25.h,
              color: ColorsManager.mainColor,
            ),
            horizontalSpace(10),
            Text(
              carTyp.type ?? "",
              style: TextStyles.font14Bold,
            ),
          ],
        ),
      ),
    );
  }
}
