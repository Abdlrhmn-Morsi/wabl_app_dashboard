import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_helper_functions.dart';
import '../../../../../core/helpers/app_size.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/app_cach_image.dart';
import '../../../data/models/chat_response_body.dart';

class ConversationsListViewItem extends StatelessWidget {
  final ChatResponseBody chat;
  final void Function()? onTap;
  const ConversationsListViewItem({
    super.key,
    this.onTap,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: AppSize.fullWidth(context),
        child: Row(
          children: [
            Hero(
              tag: chat.chatWith?.id ?? -1,
              child: AppCachImage(
                height: 55.w,
                width: 55.w,
                image: chat.chatWith?.avatar ?? "",
                isNoBaseUrl: true,
              ),
            ),
            horizontalSpace(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.chatWith?.name ?? "",
                  style: TextStyles.font12Bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(2),
                chat.lastMessage?.message == null
                    ? const SizedBox.shrink()
                    : Text(
                        chat.lastMessage?.isDeleted == true
                            ? "This message has been deleted"
                            : chat.lastMessage?.message ?? "",
                        style: TextStyles.font12GrayRegular,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                verticalSpace(4),
                chat.lastMessage?.createdAt == null
                    ? const SizedBox.shrink()
                    : Text(
                        AppHelperFunctions.formatedDate(
                          chat.lastMessage?.createdAt?.toDate(),
                        ),
                        style: TextStyles.font10Bold.copyWith(
                          color: ColorsManager.gray,
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
