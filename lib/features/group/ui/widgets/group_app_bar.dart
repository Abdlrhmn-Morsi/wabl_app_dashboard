import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/helpers/extensions.dart';

import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_delete_alert_bottom_sheet.dart';
import '../../logic/create_group_cubit.dart';

class GroupAppBar extends StatelessWidget {
  final String title;
  final bool isUpdate;
  const GroupAppBar({
    super.key,
    required this.title,
    required this.isUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
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
          !isUpdate
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () {
                    appDeleteAlertBottomSheet(
                      context: context,
                      message:
                          'are_you_sure_you_want_to_delete_this_group'.tr(),
                      onTapAction: () {
                        CreateGroupCubit.get.emitDeleteGroup();
                      },
                    );
                  },
                  child: Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                    size: 30.sp,
                  ),
                ),
        ],
      ),
    );
  }
}
