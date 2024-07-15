import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/spacing.dart';
import '../logic/profile_cubit.dart';
import 'bloc_listeners/update_user_info_bloc_listener.dart';
import 'widgets/profile_app_bar.dart';
import 'widgets/profile_data_options.dart';
import 'widgets/profile_image.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  void initState() {
    super.initState();
    ProfileCubit.get.getUserInfo(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                //? UpdateUserInfoBlocListener
                const UpdateUserInfoBlocListener(),
                //?
                verticalSpace(20),
                const ProfileAppBar(),
                verticalSpace(30),
                const ProfileImage(),
                verticalSpace(40),
                const ProfileDataOptions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
