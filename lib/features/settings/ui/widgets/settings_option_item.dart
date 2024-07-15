import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/styles.dart';

class SettingsOptionItem extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const SettingsOptionItem({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyles.font16Medium),
          Icon(
            Icons.keyboard_arrow_right_outlined,
            size: 25.w,
          ),
        ],
      ),
    );
  }
}
