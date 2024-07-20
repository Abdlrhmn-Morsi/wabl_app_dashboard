import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/helpers/extensions.dart';
import 'package:wabl_app_dashboard/core/widgets/app_global_app_bar.dart';
import 'package:wabl_app_dashboard/features/post_settings/ui/screens/car_type/car_type_screen.dart';
import 'package:wabl_app_dashboard/features/post_settings/ui/screens/manufacture_year/manufacture_year_screen.dart';
import '../../../core/helpers/spacing.dart';
import 'widgets/post_settings_item.dart';

class PostSettingsScreen extends StatelessWidget {
  const PostSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20),
              AppGlobalAppBar(
                title: 'ad_settings'.tr(context: context),
              ),
              verticalSpace(40),
              PostSettingsItem(
                title: "manufacture_year".tr(context: context),
                onTap: () {
                  const ManufacturerYearScreen().goOnWidget(context);
                },
              ),
              verticalSpace(12),
              PostSettingsItem(
                title: "car_type".tr(context: context),
                onTap: () {
                  const CarTypeScreen().goOnWidget(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
