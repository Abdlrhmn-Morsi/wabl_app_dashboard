import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../logic/profile_cubit.dart';
import '../../logic/profile_state.dart';
import '../screens/edit_country_code_screen.dart';
import '../screens/edit_name_screen.dart';
import '../screens/edit_password_screen.dart';
import '../screens/edit_phone_screen.dart';
import 'profile_option.dart';

class ProfileDataOptions extends StatelessWidget {
  const ProfileDataOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current is GetUserInfoSuccess,
      builder: (context, state) {
        var cubit = ProfileCubit.get;
        return Column(
          children: [
            ProfileOption(
              title: 'email'.tr(context: context),
              value: cubit.profileData.email ?? "",
              hideEdit: true,
            ),
            verticalSpace(30),
            ProfileOption(
              title: 'name'.tr(context: context),
              value: cubit.profileData.name ?? "",
              onTap: () {
                EditNameScreen(name: cubit.profileData.name ?? "")
                    .goOnWidget(context);
              },
            ),
            verticalSpace(25),
            ProfileOption(
              title: 'Phone'.tr(context: context),
              value: cubit.profileData.phone ?? "",
              onTap: () {
                EditPhoneScreen(
                  phone: cubit.profileData.phone ?? "",
                ).goOnWidget(context);
              },
            ),
            verticalSpace(25),
            ProfileOption(
              title: 'country_code'.tr(context: context),
              value: '+${cubit.profileData.countryCode ?? "20"}',
              onTap: () {
                EditCountryCodeScreen(
                  countryCode: cubit.profileData.countryCode ?? '20',
                ).goOnWidget(context);
              },
            ),
            verticalSpace(25),
            ProfileOption(
              title: 'password'.tr(context: context),
              value: '***************',
              onTap: () {
                const EditPasswordScreen().goOnWidget(context);
              },
            ),
          ],
        );
      },
    );
  }
}
