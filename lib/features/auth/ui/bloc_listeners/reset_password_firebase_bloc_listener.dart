import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/app_message_dialog.dart';
import '../../logic/forget_password_cubit.dart';
import '../../logic/forget_password_state.dart';

class ResetPasswordFirebaseBlocListener extends StatelessWidget {
  const ResetPasswordFirebaseBlocListener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            FocusManager.instance.primaryFocus?.unfocus();
            AppLoading.loading(context);
          },
          success: (data) {
            context.pop();
            context.pushAndReplaceAllNamed(Routes.logInScreen);
            AppMessage.show(
              context: context,
              message: 'check_your_email_to_reset_password'.tr(),
            );
          },
          error: (message) {
            context.pop();
            AppMessage.show(
              context: context,
              message: message,
              isError: true,
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
