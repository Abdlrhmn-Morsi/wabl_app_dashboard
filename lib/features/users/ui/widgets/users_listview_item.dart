import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/helpers/spacing.dart';
import 'package:wabl_app_dashboard/core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_cach_image.dart';
import '../../data/models/user_response_body.dart';

class UsersListViewItem extends StatelessWidget {
  final UserResponseBody user;
  final void Function()? onTap;
  const UsersListViewItem({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppCachImage(
          width: 50.w,
          height: 50.w,
          image: user.avatar ?? "",
          isNoBaseUrl: true,
          isNotCircle: true,
        ),
        horizontalSpace(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                user.name ?? "",
                style: TextStyles.font14Bold.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
              verticalSpace(4),
              Text(
                user.email ?? "",
                style: TextStyles.font12Bold.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        horizontalSpace(10),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 4.h,
              horizontal: 8.w,
            ),
            decoration: BoxDecoration(
              color: ColorsManager.mainColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              'hire'.tr(context: context),
              style: TextStyles.font12Medium.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
