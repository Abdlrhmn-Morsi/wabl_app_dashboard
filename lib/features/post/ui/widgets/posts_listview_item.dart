import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/widgets/app_alert_bottom_sheet.dart';
import 'package:wabl_app_dashboard/features/post/logic/update_post_cubit.dart';
import 'package:wabl_app_dashboard/features/post/logic/update_post_state.dart';
import '../../../../core/helpers/app_helper_functions.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/routing/screen_argument.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_cach_image.dart';
import '../../../settings/ui/widgets/dark_mode_switch.dart';
import '../../data/post_response_body.dart';
import 'post_details.dart';
import 'posts_listview_item_images.dart';

class PostsListviewItem extends StatefulWidget {
  final PostResponseBody post;
  const PostsListviewItem({
    super.key,
    required this.post,
  });

  @override
  State<PostsListviewItem> createState() => _PostsListviewItemState();
}

class _PostsListviewItemState extends State<PostsListviewItem> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(
              Routes.profileScreen,
              arguments: ScreenArgument(
                {
                  'post_owner': PostOwner(
                    id: widget.post.relatedToId ?? "",
                    avatar: widget.post.postOwner?.avatar ?? '',
                    name: widget.post.postOwner?.name ?? "",
                  ),
                },
              ),
            );
          },
          child: Row(
            children: [
              AppCachImage(
                image: widget.post.postOwner?.avatar ?? "",
                isNoBaseUrl: true,
                height: 40.h,
                width: 40.h,
              ),
              horizontalSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.postOwner?.name ?? "",
                      style: TextStyles.font12Bold.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    verticalSpace(2),
                    Text(
                      AppHelperFunctions.formatedDate(
                        widget.post.createdAt?.toDate(),
                      ),
                      style: TextStyles.font10GrayRegular.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              BlocBuilder<UpdatePostCubit, UpdatePostState>(
                buildWhen: (previous, current) =>
                    current is Loading ||
                    current is Success ||
                    current is Error,
                builder: (context, state) {
                  var cubit = UpdatePostCubit.get;
                  return AppCupertinoSwitch(
                    value: widget.post.isEnabled ?? false,
                    onChanged: (v) {
                      appAlertBottomSheet(
                        context: context,
                        message: widget.post.isEnabled == true
                            ? "are_you_sure_to_unpublish_this_post".tr()
                            : 'are_you_sure_to_publish_this_post'.tr(),
                        onTapAction: () {
                          if (widget.post.isEnabled == true) {
                            cubit.emitUpdatePost(
                              context: context,
                              isEnabled: false,
                              postId: widget.post.id ?? "",
                              post: widget.post,
                            );
                          }
                          if (widget.post.isEnabled == false) {
                            cubit.emitUpdatePost(
                              context: context,
                              isEnabled: true,
                              postId: widget.post.id ?? "",
                              post: widget.post,
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        verticalSpace(10),
        PostsListviewItemImages(
          images: widget.post.images ?? [],
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
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
