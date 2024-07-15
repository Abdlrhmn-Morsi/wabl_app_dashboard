import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';

import '../../../core/helpers/extensions.dart';
import '../../../core/widgets/app_loading.dart';
import '../../../core/widgets/app_message_dialog.dart';
import '../../../core/widgets/app_toast.dart';
import '../logic/update_post_cubit.dart';
import '../logic/update_post_state.dart';

class DeletePostBlocListener extends StatelessWidget {
  const DeletePostBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdatePostCubit, UpdatePostState>(
      listenWhen: (previous, current) =>
          current is DeleteLoading ||
          current is DeleteSuccess ||
          current is DeleteError,
      listener: (context, state) {
        state.whenOrNull(
          deleteLoading: () {
            FocusManager.instance.primaryFocus?.unfocus();
            AppLoading.loading(context);
          },
          deleteSuccess: (data) {
            context.pop();
            context.pop();
            AppToast.show(
              context: context,
              message: 'Post deleted successfully',
            );
          },
          deleteError: (message) {
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
