import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_password_text_field.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../logic/signup_cubit.dart';
import '../../logic/signup_state.dart';
import 'phone_with_country_code.dart';

class SignUpFields extends StatelessWidget {
  const SignUpFields({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        var cubit = SignupCubit.get;
        return Column(
          children: [
            AppTextField(
              controller: cubit.nameTEC,
              hintText: 'full_name'.tr(),
              isNoBorder: true,
              validator: AppRegex.checkFullName,
            ),
            verticalSpace(16),
            AppTextField(
              controller: cubit.emailTEC,
              hintText: 'email'.tr(),
              isNoBorder: true,
              validator: AppRegex.emailValidation,
            ),
            verticalSpace(16),
            const PhoneWithCountryCode(),
            verticalSpace(16),
            AppPasswordTextField(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: cubit.passwordTEC,
              hintText: 'password'.tr(),
              isNoBorder: true,
              validator: AppRegex.passwordValidation,
            ),
            verticalSpace(16),
            AppPasswordTextField(
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: cubit.confirmPasswordTEC,
              hintText: 'confirm_password'.tr(),
              isNoBorder: true,
              validator: (v) {
                return AppRegex.confirmationPasswordValidation(
                  confirmPassword: v,
                  password: cubit.passwordTEC.text,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
