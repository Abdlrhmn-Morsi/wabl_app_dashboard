import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/app_message_dialog.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../logic/forget_password_cubit.dart';
import '../../logic/forget_password_state.dart';

class ForgetPasswordBlocListener extends StatelessWidget {
  final bool isFogetPassword;
  final bool isCheckResetCode;
  final bool isResetPassword;
  const ForgetPasswordBlocListener({
    super.key,
    this.isFogetPassword = false,
    this.isCheckResetCode = false,
    this.isResetPassword = false,
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
            if (isFogetPassword) {
              context.pushReplacementNamed(Routes.checkResetCodeScreen);
            }
            if (isCheckResetCode) {
              context.pushReplacementNamed(Routes.resetPasswordScreen);
            }
            if (isResetPassword) {
              AppToast.show(
                context: context,
                message: 'Password Changed Successfuly!',
              );
              context.pushAndReplaceAllNamed(Routes.logInScreen);
            }
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
