import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_helper_functions.dart';
import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/routing/screen_argument.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/app_cach_image.dart';
import '../../../../auth/logic/auth_helper.dart';
import '../../../../post/data/post_response_body.dart';
import '../../../../post/ui/widgets/post_details.dart';
import '../../../../post/ui/widgets/posts_listview_item_images.dart';

class ProfilePostsListviewItem extends StatefulWidget {
  final PostResponseBody post;
  final int index;
  const ProfilePostsListviewItem({
    super.key,
    required this.post,
    required this.index,
  });

  @override
  State<ProfilePostsListviewItem> createState() =>
      _ProfilePostsListviewItemState();
}

class _ProfilePostsListviewItemState extends State<ProfilePostsListviewItem> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AppCachImage(
                  image: widget.post.postOwner?.avatar ?? "",
                  isNoBaseUrl: true,
                  height: 50.h,
                  width: 50.h,
                ),
                horizontalSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.postOwner?.name ?? "",
                      style: TextStyles.font14Bold,
                    ),
                    verticalSpace(2),
                    Text(
                      AppHelperFunctions.formatedDate(
                        widget.post.createdAt?.toDate(),
                      ),
                      style: TextStyles.font12Regular,
                    ),
                  ],
                ),
              ],
            ),
            !AuthHelper.isMe(widget.post.relatedToId ?? "")
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        Routes.updatePostScreen,
                        arguments: ScreenArgument({
                          'post': widget.post,
                        }),
                      );
                    },
                    child: Icon(
                      Icons.edit,
                      color: ColorsManager.mainColor,
                      size: 20.sp,
                    ),
                  ),
          ],
        ),
        verticalSpace(10),
        PostsListviewItemImages(
          currentIndex: currentIndex,
          images: widget.post.images ?? [],
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        verticalSpace(10),
        PostDetails(
          currentIndex: currentIndex,
          post: widget.post,
        ),
      ],
    );
  }
}
