import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class AppKeyAndvalue extends StatelessWidget {
  final String mainKey;
  final String value;
  final Color? valueColor;
  final Color? keyColor;
  final double? keyfontSize;
  final double? valuefontSize;
  final FontWeight? valuefontWeight;
  final FontWeight? keyfontWeight;
  final TextAlign? textAlign;

  const AppKeyAndvalue({
    super.key,
    required this.mainKey,
    required this.value,
    this.valueColor,
    this.keyColor,
    this.keyfontSize,
    this.valuefontSize,
    this.valuefontWeight,
    this.keyfontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      maxLines: 2,
      text: TextSpan(
        children: [
          TextSpan(
            text: '$mainKey : ',
            style: TextStyle(
              color: keyColor ?? AppColorsTheme.blackAndWhiteSwitch(context),
              fontWeight: keyfontWeight,
              fontSize: keyfontSize ?? 12.sp,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: valueColor ?? AppColorsTheme.blackAndWhiteSwitch(context),
              fontSize: valuefontSize ?? 10.sp,
              fontWeight: valuefontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
