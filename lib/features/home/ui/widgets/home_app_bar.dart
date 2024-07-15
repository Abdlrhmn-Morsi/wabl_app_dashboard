import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/features/home/ui/widgets/home_profile_with_create_post_field.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const HomeProfileAvatar(),
              horizontalSpace(10),
              GestureDetector(
                onTap: () {
                  context.pushNamed(Routes.allConversationsScreen);
                },
                child: Image.asset(
                  AppImages.chatIcon,
                  height: 25.w,
                  color: AppColorsTheme.blackAndWhiteSwitch(context),
                ),
              ),
            ],
          ),
          Image.asset(
            AppImages.appIcon,
            height: 45.h,
          ),
        ],
      ),
    );
  }
}
