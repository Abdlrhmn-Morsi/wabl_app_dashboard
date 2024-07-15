import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wabl_app_dashboard/core/helpers/extensions.dart';
import 'package:wabl_app_dashboard/features/users/logic/role_cubit.dart';
import 'package:wabl_app_dashboard/features/users/logic/role_state.dart';

import '../../../core/widgets/app_loading.dart';
import '../../../core/widgets/app_message_dialog.dart';
import '../../../core/widgets/app_toast.dart';

class UpdateRoleBlocListener extends StatelessWidget {
  const UpdateRoleBlocListener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoleCubit, RoleState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            AppLoading.loading(context);
          },
          success: (message) {
            context.pop();
            AppToast.show(
              context: context,
              message: message,
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
