import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/app_cach_image.dart';
import '../../../../../core/widgets/app_dashed_divider.dart';
import '../../../data/models/chat_response_body.dart';

class ChatAppBar extends StatelessWidget {
  final ChatWith chatWith;
  const ChatAppBar({
    super.key,
    required this.chatWith,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20.sp,
                    ),
                  ),
                  horizontalSpace(6),
                  Row(
                    children: [
                      AppCachImage(
                        height: 40.w,
                        width: 40.w,
                        image: chatWith.avatar ?? "",
                        isNoBaseUrl: true,
                      ),
                      horizontalSpace(10),
                      Text(
                        chatWith.name ?? "",
                        style: TextStyles.font12Bold,
                      ),
                    ],
                  ),
                ],
              ),
              // GestureDetector(
              //   onTap: () {
              //     ChatCubit.get.callNumber('');
              //   },
              //   child: const Icon(
              //     Icons.call,
              //     color: Colors.red,
              //   ),
              // )
            ],
          ),
          verticalSpace(8),
          const AppDividerDashed(),
        ],
      ),
    );
  }
}
