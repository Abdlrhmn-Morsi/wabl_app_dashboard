import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/app_helper_functions.dart';
import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/routing/screen_argument.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/app_cach_image.dart';
import '../../../data/post_response_body.dart';

class PostCreator extends StatelessWidget {
  const PostCreator({
    super.key,
    required this.post,
  });

  final PostResponseBody post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.profileScreen,
          arguments: ScreenArgument(
            {
              'post': post,
            },
          ),
        );
      },
      child: Row(
        children: [
          AppCachImage(
            image: post.postOwner?.avatar ?? "",
            isNoBaseUrl: true,
            height: 50.h,
            width: 50.h,
          ),
          horizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.postOwner?.name ?? "",
                style: TextStyles.font14Bold,
              ),
              verticalSpace(2),
              Text(
                AppHelperFunctions.formatedDate(
                  post.createdAt?.toDate(),
                ),
                style: TextStyles.font12Regular,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
