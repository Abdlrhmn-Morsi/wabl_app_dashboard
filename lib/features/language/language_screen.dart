// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/helpers/app_local_storage.dart';
import '../../core/helpers/spacing.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import '../../core/widgets/app_global_app_bar.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              verticalSpace(20),
              AppGlobalAppBar(title: 'language'.tr(context: context)),
              verticalSpace(40),
              LangItem(
                title: 'language_ar'.tr(context: context),
                value: 'ar',
              ),
              verticalSpace(25),
              LangItem(
                title: 'language_en'.tr(context: context),
                value: 'en',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LangItem extends StatelessWidget {
  final String title;
  final String value;
  final void Function()? onTap;
  const LangItem({
    super.key,
    required this.title,
    this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ApplocalStorage.saveString(AppSavedKey.appLang, value);
        context.setLocale(Locale(value));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.font14Bold,
          ),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorsManager.mainColor,
                width: 2,
              ),
            ),
            child: Container(
              height: 10.w,
              width: 10.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ApplocalStorage.getAppLang(context) == value
                      ? ColorsManager.mainColor
                      : Colors.transparent,
                  width: 2,
                ),
                color: ApplocalStorage.getAppLang(context) == value
                    ? ColorsManager.mainColor
                    : Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
