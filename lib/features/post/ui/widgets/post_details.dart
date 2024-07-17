import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_helper_functions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_read_more_text.dart';
import '../../data/post_response_body.dart';
import 'circle_indicators.dart';

class PostDetails extends StatelessWidget {
  final PostResponseBody post;
  final int currentIndex;
  const PostDetails({
    super.key,
    required this.post,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        post.images == null || post.images!.isEmpty
            ? Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: AppReadMoreText(
                  text: post.content ?? '',
                  style: TextStyles.font14Medium.copyWith(
                    height: 1.4,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        post.images == null || post.images!.isEmpty
            ? const SizedBox.shrink()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleIndicators(
                    length: post.images!.length,
                    currentIndex: currentIndex,
                  ),
                ],
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppHelperFunctions.formatNumber(post.viewCount ?? 0)} ${'views'.tr(context: context)}',
              style: TextStyles.font12Bold,
            ),
          ],
        ),
        verticalSpace(5),
        post.images == null || post.images!.isEmpty
            ? const SizedBox.shrink()
            : AppReadMoreText(
                text: post.content ?? '',
                style: TextStyles.font14Medium.copyWith(
                  height: 1.4,
                ),
              ),
      ],
    );
  }
}
