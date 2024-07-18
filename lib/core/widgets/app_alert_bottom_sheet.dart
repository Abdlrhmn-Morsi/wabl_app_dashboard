import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/extensions.dart';
import '../helpers/spacing.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';

Future appAlertBottomSheet({
  required BuildContext context,
  required String message,
  required Function()? onTapAction,
}) {
  FocusManager.instance.primaryFocus?.unfocus();
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        decoration: const BoxDecoration(
          //  color: Colors.red,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyles.font12Medium.copyWith(
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(20),
            Row(
              children: [
                Expanded(
                  child: AlertButton(
                    btnColor: ColorsManager.mainBoldColor,
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    title: 'ok'.tr(context: context),
                    onTap: () {
                      context.pop();
                      onTapAction!();
                    },
                  ),
                ),
                horizontalSpace(10),
                Expanded(
                  child: AlertButton(
                    borderColor: ColorsManager.mainBoldColor,
                    title: 'cancel'.tr(context: context),
                    onTap: () {
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class AlertButton extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Color? borderColor;
  final Color? btnColor;
  final Color? textColor;
  final Color? iconColor;
  final void Function()? onTap;

  const AlertButton({
    super.key,
    this.icon,
    required this.title,
    this.borderColor,
    this.btnColor,
    this.textColor,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 6.w,
          vertical: 6.h,
        ),
        decoration: BoxDecoration(
          color: btnColor,
          border: Border.all(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: TextStyles.font10Bold.copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
