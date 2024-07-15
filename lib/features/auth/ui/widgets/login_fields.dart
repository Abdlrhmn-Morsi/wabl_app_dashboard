import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_password_text_field.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../logic/login_cubit.dart';
import '../../logic/login_state.dart';

class LogInFields extends StatelessWidget {
  const LogInFields({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        var cubit = LoginCubit.get;
        return Column(
          children: [
            AppTextField(
              controller: cubit.emailTEC,
              hintText: 'Email Address',
              isNoBorder: true,
              validator: AppRegex.emailValidation,
            ),
            verticalSpace(16),
            AppPasswordTextField(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: cubit.passwordTEC,
              hintText: 'Password',
              isNoBorder: true,
              validator: AppRegex.passwordValidation,
            ),
          ],
        );
      },
    );
  }
}
