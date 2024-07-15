import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class ProfileOption extends StatelessWidget {
  final String title;
  final String value;
  final bool hideEdit;
  final void Function()? onTap;
  const ProfileOption({
    super.key,
    required this.title,
    required this.value,
    this.onTap,
    this.hideEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.font14GrayRegular,
            ),
            verticalSpace(5),
            Text(
              value,
              style: TextStyles.font14Bold,
            ),
          ],
        ),
        hideEdit
            ? const SizedBox.shrink()
            : GestureDetector(
                onTap: onTap,
                child: Image.asset(
                  AppImages.edit,
                  width: 18.w,
                  color: AppColorsTheme.blackAndWhiteSwitch(context),
                ),
              ),
      ],
    );
  }
}
