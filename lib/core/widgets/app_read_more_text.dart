import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import '../theming/styles.dart';

class AppReadMoreText extends StatelessWidget {
  final String text;
  final int? trimLines;
  final TextStyle? style;
  const AppReadMoreText({
    super.key,
    required this.text,
    this.trimLines,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: trimLines ?? 2,
      style: style ?? TextStyles.font12Regular.copyWith(height: 1.4),
      colorClickableText: Colors.pink,
      trimMode: TrimMode.Line,
      trimCollapsedText: '\nSee more ...',
      trimExpandedText: '\nSee less ...',
      moreStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
      lessStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
