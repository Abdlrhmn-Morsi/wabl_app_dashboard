import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/routing/screen_argument.dart';
import '../../../../core/widgets/app_cach_image.dart';
import '../../../post/data/post_response_body.dart';
import '../../../profile/logic/profile_cubit.dart';
import '../../../profile/logic/profile_state.dart';

class HomeProfileAvatar extends StatefulWidget {
  const HomeProfileAvatar({super.key});

  @override
  State<HomeProfileAvatar> createState() => _HomeProfileAvatarState();
}

class _HomeProfileAvatarState extends State<HomeProfileAvatar> {
  @override
  void initState() {
    super.initState();
    ProfileCubit.get.getUserInfo(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current is GetUserInfoLoading ||
          current is GetUserInfoSuccess ||
          current is GetUserInfoError,
      builder: (context, state) {
        var cubit = ProfileCubit.get;
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                context.pushNamed(
                  Routes.profileScreen,
                  arguments: ScreenArgument(
                    {
                      'post_owner': PostOwner(
                        id: cubit.profileData.userId ?? "",
                        avatar: cubit.profileData.avatar ?? '',
                        name: cubit.profileData.name ?? "",
                      ),
                    },
                  ),
                );
              },
              child: AppCachImage(
                image: cubit.profileData.avatar ?? "",
                isNoBaseUrl: true,
                height: 40.w,
                width: 40.w,
              ),
            ),
          ],
        );
      },
    );
  }
}
