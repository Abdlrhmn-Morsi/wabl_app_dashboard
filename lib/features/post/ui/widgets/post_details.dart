import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_helper_functions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_read_more_text.dart';
import '../../data/post_response_body.dart';
import 'circle_indicators.dart';
import 'post_tag.dart';

class PostDetails extends StatelessWidget {
  final PostResponseBody post;
  final void Function()? onTapSaved;
  final void Function()? onTapFavorite;
  final int currentIndex;
  const PostDetails({
    super.key,
    required this.post,
    required this.currentIndex,
    this.onTapSaved,
    this.onTapFavorite,
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
        verticalSpace(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppHelperFunctions.formatNumber(post.viewCount ?? 0)} ${'views'.tr()}',
              style: TextStyles.font12Bold,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: onTapFavorite,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.grey,
                        size: 25.sp,
                      ),
                      Text(
                        AppHelperFunctions.formatNumber(
                          post.favoriteCount ?? 0,
                        ),
                        style: TextStyles.font10Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        verticalSpace(10),
        SizedBox(
          height: 22.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              post.carType == null || post.carType!.isEmpty
                  ? const SizedBox.shrink()
                  : AppPostTag(
                      title: 'car_type'.tr(),
                      name: post.carType ?? "",
                    ),
              horizontalSpace(10),
              post.manufactureYear == null || post.manufactureYear!.isEmpty
                  ? const SizedBox.shrink()
                  : AppPostTag(
                      title: 'manufacture_year'.tr(),
                      name: post.manufactureYear ?? "",
                    ),
              horizontalSpace(10),
              post.price == null || post.price!.isEmpty
                  ? const SizedBox.shrink()
                  : AppPostTag(
                      title: 'price'.tr(),
                      name: post.price ?? "",
                    ),
            ],
          ),
        ),
        verticalSpace(6),
        post.group == null || post.group!.name!.isEmpty
            ? const SizedBox.shrink()
            : AppPostTag(
                title: 'group'.tr(),
                name: post.group?.name ?? "",
                color: ColorsManager.secondaryColor,
              ),
        verticalSpace(4),
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
