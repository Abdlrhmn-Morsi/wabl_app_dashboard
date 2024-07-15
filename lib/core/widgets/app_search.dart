import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/app_images.dart';
import '../helpers/spacing.dart';
import '../theming/colors.dart';
import 'app_text_field.dart';

class AppSearch extends StatelessWidget {
  final String? hint;
  final void Function(String)? onChanged;
  final void Function()? onTapSearch;
  final void Function()? onTapFilter;
  final TextEditingController? controller;

  const AppSearch({
    super.key,
    this.onChanged,
    this.controller,
    this.onTapSearch,
    this.hint,
    this.onTapFilter,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              controller: controller,
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              isNoBorder: true,
              onChanged: onChanged,
              validator: (p0) {
                return null;
              },
            ),
          ),
          horizontalSpace(10),
          SearchIcon(
            onTap: onTapSearch,
          ),
        ],
      ),
    );
  }
}

class SearchIcon extends StatelessWidget {
  final void Function()? onTap;
  const SearchIcon({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.h,
        ),
        decoration: BoxDecoration(
          color: ColorsManager.mainColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Image.asset(
          AppImages.search,
          color: Colors.white,
          width: 25.w,
          height: 25.w,
        ),
      ),
    );
  }
}
