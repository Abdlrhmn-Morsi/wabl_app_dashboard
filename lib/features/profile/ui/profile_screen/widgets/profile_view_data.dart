import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/helpers/app_images.dart';
import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/routing/screen_argument.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/app_cach_image.dart';
import '../../../../auth/logic/auth_helper.dart';
import '../../../../chat/data/models/chat_response_body.dart';
import '../../../../post/data/post_response_body.dart';
import '../../../logic/profile_cubit.dart';
import '../../../logic/profile_state.dart';

class ProfileViewData extends StatelessWidget {
  final PostOwner postOwner;

  const ProfileViewData({
    super.key,
    required this.postOwner,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current is GetUserInfoLoading ||
          current is GetUserInfoSuccess ||
          current is GetUserInfoError,
      builder: (context, state) {
        // var cubit = ProfileCubit.get;
        // bool isMe = AuthHelper.isMe(postOwner.id ?? "");
        // var data = isMe
        // ? PostOwner(
        //     id: cubit.profileData.userId ?? "",
        //     avatar: cubit.profileData.avatar ?? "",
        //     name: cubit.profileData.name ?? "",
        //   )
        // : postOwner;
        var data = postOwner;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppCachImage(
              image: data.avatar ?? "",
              width: 80.w,
              height: 80.w,
              isNoBaseUrl: true,
            ),
            verticalSpace(10),
            Text(
              data.name ?? "",
              style: TextStyles.font16Medium,
            ),
            verticalSpace(5),
            AuthHelper.isMe(postOwner.id ?? "")
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        Routes.chatScreen,
                        arguments: ScreenArgument({
                          'chat_with': ChatWith(
                            id: postOwner.id ?? "",
                            avatar: postOwner.avatar ?? "",
                            name: postOwner.name ?? "",
                          ),
                        }),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColorsTheme.blackAndWhite(context),
                        ),
                        borderRadius: BorderRadius.circular(50.r),
                        color: ColorsManager.mainBoldColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'chat'.tr(context: context),
                            style: TextStyles.font14Bold.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          horizontalSpace(10),
                          Lottie.asset(
                            AppImages.chat,
                            width: 20.w,
                            height: 20.w,
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
