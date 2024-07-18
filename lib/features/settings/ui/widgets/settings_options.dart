// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_logout_alert_message_dialog.dart';
import '../../../auth/logic/login_cubit.dart';
import '../../screens/about_us.dart';
import '../../screens/privacy_policy_screen.dart';
import '../../screens/terms_and_conditions_screen.dart';
import 'dark_mode_switch.dart';
import 'settings_option_item.dart';

class SettingsOptions extends StatelessWidget {
  const SettingsOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DarkModeSwitch(),
        verticalSpace(10),
        // SettingsOptionItem(
        //   title: 'settings'.tr(context: context),
        // ),
        // verticalSpace(20),
        SettingsOptionItem(
          title: 'about_us'.tr(context: context),
          onTap: () {
            const AboutUs().goOnWidget(context);
          },
        ),
        verticalSpace(15),
        SettingsOptionItem(
          title: 'privacy_policy'.tr(context: context),
          onTap: () {
            const PrivacyPolicyScreen().goOnWidget(context);
          },
        ),

        verticalSpace(20),
        SettingsOptionItem(
          title: 'terms_and_conditions'.tr(context: context),
          onTap: () {
            const TermsAndConditionsScreen().goOnWidget(context);
          },
        ),

        verticalSpace(20),
        SettingsOptionItem(
          title: 'change_language'.tr(context: context),
          onTap: () {
            context.pushNamed(Routes.languageScreen);
          },
        ),
        verticalSpace(10),
        const Divider(thickness: 1),
        verticalSpace(10),
        LogoutOrDeleteAccountBtn(
          icon: AppImages.logout,
          title: 'logout'.tr(context: context),
          onTap: () {
            AppLogoutAlertMessage.show(
              title: 'logout'.tr(context: context),
              context: context,
              message: 'are_you_sure_you_want_to_logout'.tr(),
              onSubbmit: () {
                Navigator.pop(context);
                LoginCubit.get.logout(context: context);
              },
            );
          },
        ),
        // verticalSpace(20),
        // LogoutOrDeleteAccountBtn(
        //   icon: AppImages.trash,
        //   title: 'delete_account'.tr(),
        //   onTap: () {
        //     AppLogoutAlertMessage.show(
        //       title: 'delete_account'.tr(),
        //       context: context,
        //       message: 'are_you_sure_you_want_to_delete_your_account'.tr(),
        //       onSubbmit: () {
        //         Navigator.pop(context);
        //         LoginCubit.get.deleteAccount(context: context);
        //       },
        //     );
        //   },
        // ),
      ],
    );
  }
}

class LogoutOrDeleteAccountBtn extends StatelessWidget {
  final String title;
  final String icon;
  final void Function()? onTap;
  const LogoutOrDeleteAccountBtn({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            icon,
            height: 20.h,
            color: Colors.red,
          ),
          horizontalSpace(10),
          Text(
            title,
            style: TextStyles.font14Bold,
          ),
        ],
      ),
    );
  }
}
