import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_cach_image.dart';
import '../../../../core/widgets/app_read_more_text.dart';
import '../../data/goup_model.dart';

class GroupsListviewItem extends StatelessWidget {
  final GroupModel group;
  final void Function()? onTap;
  const GroupsListviewItem({
    super.key,
    required this.group,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          AppCachImage(
            image: group.avatar ?? "",
            isNotCircle: true,
            isNoBaseUrl: true,
            height: 60.w,
            width: 60.w,
          ),
          horizontalSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name ?? "",
                  style: TextStyles.font14Bold.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                verticalSpace(5),
                AppReadMoreText(
                  text: group.description ?? "",
                  style: TextStyles.font10GrayRegular.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
