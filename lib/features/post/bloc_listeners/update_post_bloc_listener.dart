import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';

import '../../../core/helpers/extensions.dart';
import '../../../core/widgets/app_loading.dart';
import '../../../core/widgets/app_message_dialog.dart';
import '../../../core/widgets/app_toast.dart';
import '../logic/update_post_cubit.dart';
import '../logic/update_post_state.dart';

class UpdatePostBlocListener extends StatelessWidget {
  const UpdatePostBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdatePostCubit, UpdatePostState>(
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
            AppToast.show(
              context: context,
              message: 'Post updated successfully',
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
