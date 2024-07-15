import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/app_message_dialog.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../logic/profile_cubit.dart';
import '../../logic/profile_state.dart';

class UpdateUserInfoBlocListener extends StatelessWidget {
  const UpdateUserInfoBlocListener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) =>
          current is UpdateUserInfoLoading ||
          current is UpdateUserInfoSuccess ||
          current is UpdateUserInfoError,
      listener: (context, state) {
        state.whenOrNull(
          updateUserInfoLoading: () {
            FocusManager.instance.primaryFocus?.unfocus();
            AppLoading.loading(context);
          },
          updateUserInfoSuccess: (data) {
            context.pop();
            FocusManager.instance.primaryFocus?.unfocus();
            AppToast.show(
              context: context,
              message: 'Updated Successfuly!',
            );
          },
          updateUserInfoError: (message) {
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
