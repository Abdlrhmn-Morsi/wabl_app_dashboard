import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/app_images.dart';
import '../helpers/spacing.dart';
import '../theming/colors.dart';
import 'app_text_field.dart';

class AppSearchBar extends StatelessWidget {
  final bool isNoPadding;
  final String? hintText;
  final TextEditingController? controller;
  final void Function()? onTap;
  const AppSearchBar({
    Key? key,
    this.hintText,
    this.controller,
    this.onTap,
    this.isNoPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isNoPadding
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 35.h,
              child: AppTextField(
                controller: controller,
                hintText: hintText ?? 'search',
                prefixIcon: const Icon(Icons.search),
                borderRadius: BorderRadius.circular(8),
                unFocusedBorderColor: Colors.transparent,
                validator: (v) {
                  return null;
                },
              ),
            ),
          ),
          horizontalSpace(10),
          GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              onTap?.call();
            },
            child: Container(
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsManager.mainBoldColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColorsTheme.adaptiveShadow(context),
                    blurRadius: 1,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Image.asset(
                AppImages.searchTap,
                height: 16.h,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
