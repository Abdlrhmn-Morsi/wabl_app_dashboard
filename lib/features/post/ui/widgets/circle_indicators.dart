import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';

class CircleIndicators extends StatelessWidget {
  final int length;
  final int currentIndex;
  const CircleIndicators({
    super.key,
    required this.length,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return length == 0
        ? const SizedBox.shrink()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              length,
              (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  height: 6.h,
                  width: 6.h,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? ColorsManager.mainBoldColor
                        : ColorsManager.lightGray,
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          );
  }
}
