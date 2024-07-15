import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';

class AddPostBtn extends StatelessWidget {
  const AddPostBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.addPostScreen);
      },
      child: Container(
        padding: EdgeInsets.all(14.sp),
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
        child: Image.asset(
          AppImages.write,
          height: 30.h,
          color: Colors.white,
        ),
      ),
    );
  }
}
