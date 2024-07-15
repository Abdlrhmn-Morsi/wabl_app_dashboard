import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../data/models/category_response_body.dart';

class CategoriesListviewItem extends StatelessWidget {
  final void Function()? onTap;
  final bool isSelected;
  final CategoryResponseBody cat;
  const CategoriesListviewItem({
    super.key,
    required this.isSelected,
    this.onTap,
    required this.cat,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 15.sp,
          vertical: 5.sp,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? ColorsManager.mainColor : ColorsManager.gray,
        ),
        child: Text(
          cat.enName ?? '',
          style: TextStyles.font12Bold.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
