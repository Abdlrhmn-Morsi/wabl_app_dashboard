import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/extensions.dart';
import '../theming/styles.dart';

class AppGlobalAppBar extends StatelessWidget {
  final bool isWithPadding;
  final void Function()? onTapBack;
  final String title;
  final bool isDefaultBackActive;
  const AppGlobalAppBar({
    super.key,
    this.isWithPadding = false,
    this.isDefaultBackActive = true,
    required this.title,
    this.onTapBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isWithPadding
          ? EdgeInsets.symmetric(horizontal: 16.w)
          : const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              isDefaultBackActive ? context.pop() : onTapBack?.call();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.sp,
            ),
          ),
          Text(
            title,
            style: TextStyles.font16Bold,
          ),
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}
