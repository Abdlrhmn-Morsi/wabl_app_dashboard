import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/app_message_dialog.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../logic/update_password_cubit.dart';
import '../../logic/update_password_state.dart';

class UpdatePasswordBlocListener extends StatelessWidget {
  const UpdatePasswordBlocListener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdatePasswordCubit, UpdatePasswordState>(
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
            context.pop();
            FocusManager.instance.primaryFocus?.unfocus();
            AppToast.show(
              context: context,
              message: 'Password Updated Successfuly!',
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
