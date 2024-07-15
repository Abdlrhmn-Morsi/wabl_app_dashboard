import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/features/auth/logic/auth_helper.dart';
import 'package:wabl_app_dashboard/features/post/data/post_response_body.dart';

import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/styles.dart';

class ProfileAppBar extends StatelessWidget {
  final PostOwner postOwner;
  const ProfileAppBar({super.key, required this.postOwner});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20.sp,
          ),
        ),
        Text(
          'Profile',
          style: TextStyles.font16Bold,
        ),
        !AuthHelper.isMe(postOwner.id ?? "")
            ? const SizedBox.shrink()
            : GestureDetector(
                onTap: () {
                  context.pushNamed(Routes.profileSettingsScreen);
                },
                child: const Icon(Icons.settings),
              ),
      ],
    );
  }
}
