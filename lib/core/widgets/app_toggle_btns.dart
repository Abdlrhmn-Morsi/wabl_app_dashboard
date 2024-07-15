import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/widgets/app_text_button.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';

// ignore: must_be_immutable
class AppToggleBtns extends StatefulWidget {
  final List<String> titlesList;
  final TextStyle? textStyleFocused;
  final TextStyle? textStyleUnFocused;
  int chosenIndex;
  final int? targetTapIndex;
  final void Function(int index)? onTap;

  AppToggleBtns({
    super.key,
    required this.titlesList,
    this.onTap,
    this.textStyleFocused,
    this.textStyleUnFocused,
    this.chosenIndex = 0,
    this.targetTapIndex,
  });

  @override
  State<AppToggleBtns> createState() => _AppToggleBtnsState();
}

class _AppToggleBtnsState extends State<AppToggleBtns> {
  // int chosenValue = 0;
  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.defultItem > widget.titlesList.length - 1) {
  //     chosenValue = 0;
  //   } else {
  //     chosenValue = widget.defultItem;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.mainSemiLightColor,
        borderRadius: BorderRadius.circular(
          8.r,
        ),
      ),
      child: Row(
          children: List.generate(
        widget.titlesList.length,
        (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: AppTextButton(
                buttonHeight: 40.h,
                buttonText: widget.titlesList[index],
                backgroundColor: widget.chosenIndex == index
                    ? ColorsManager.mainColor
                    : ColorsManager.mainSemiLightColor,
                textStyle: widget.chosenIndex == index
                    ? widget.textStyleFocused ?? TextStyles.font14Medium
                    : widget.textStyleUnFocused ?? TextStyles.font12Medium,
                textColor:
                    widget.chosenIndex == index ? Colors.white : Colors.black,
                onPressed: () {
                  if (widget.targetTapIndex == null) {
                    setState(() {
                      widget.chosenIndex = index;
                    });
                    widget.onTap?.call(index);
                  } else if (widget.targetTapIndex != null &&
                      widget.targetTapIndex == index) {
                    widget.onTap?.call(index);
                  }
                },
              ),
            ),
          );
        },
      ).toList()),
    );
  }
}
