import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_size.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/app_cach_image.dart';
import '../../logic/profile_cubit.dart';
import '../../logic/profile_state.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current is GetUserInfoSuccess || current is ImagePacked,
      builder: (context, state) {
        var cubit = ProfileCubit.get;
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                ProfileCubit.get.selectPersonImage();
              },
              child: Stack(
                children: [
                  cubit.personImg == null
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColorsTheme.blackAndWhite(context),
                            ),
                          ),
                          child: AppCachImage(
                            isNoBaseUrl: true,
                            image: cubit.profileData.avatar ?? "",
                            width: AppSize.fullWidth(context) * .25,
                            height: AppSize.fullWidth(context) * .25,
                            placeholderFit: BoxFit.contain,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: ColorsManager.gray,
                            ),
                            child: Image.file(
                              cubit.personImg ?? File(''),
                              width: AppSize.fullWidth(context) * .25,
                              height: AppSize.fullWidth(context) * .25,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  Positioned(
                    right: 3,
                    bottom: 3,
                    child: Icon(
                      Icons.cameraswitch_outlined,
                      size: 20.w,
                      color: ColorsManager.mainBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            cubit.personImg == null
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      verticalSpace(5),
                      GestureDetector(
                        onTap: () async {
                          await cubit.emitUploadImage(
                            context: context,
                          );
                        },
                        child: Icon(
                          Icons.cloud_upload,
                          size: 26.sp,
                          color: ColorsManager.secondaryColor,
                        ),
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
