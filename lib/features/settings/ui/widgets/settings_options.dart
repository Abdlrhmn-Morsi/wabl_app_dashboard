import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_logout_alert_message_dialog.dart';
import '../../../auth/logic/login_cubit.dart';
import 'settings_option_item.dart';
import 'dark_mode_switch.dart';

class SettingsOptions extends StatelessWidget {
  const SettingsOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DarkModeSwitch(),
        verticalSpace(5),
        const SettingsOptionItem(title: 'Settings'),
        verticalSpace(10),
        const SettingsOptionItem(title: 'Help'),
        verticalSpace(10),
        const SettingsOptionItem(title: 'about us'),
        verticalSpace(10),
        const SettingsOptionItem(title: 'Terms and Conditions'),
        verticalSpace(10),
        const SettingsOptionItem(title: 'Privacy policy'),
        verticalSpace(10),
        const SettingsOptionItem(title: 'Change Language'),
        verticalSpace(10),
        const Divider(thickness: 1),
        verticalSpace(10),
        const LogOutBtn(),
      ],
    );
  }
}

class LogOutBtn extends StatelessWidget {
  const LogOutBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppLogoutAlertMessage.show(
          context: context,
          message: 'Are you sure u want to logout?',
          onSubbmit: () {
            Navigator.pop(context);
            LoginCubit.get.logout(context: context);
          },
        );
      },
      child: Row(
        children: [
          Image.asset(
            AppImages.logout,
            height: 20.h,
            color: Colors.red,
          ),
          horizontalSpace(10),
          Text(
            'Log out',
            style: TextStyles.font14Bold,
          ),
        ],
      ),
    );
  }
}
