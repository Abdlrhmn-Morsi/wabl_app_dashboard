import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/app_toast.dart';
import '../../post/logic/update_post_state.dart';
import '../logic/chat_cubit.dart';
import '../logic/chat_state.dart';

class DeleteMessagesBlocListener extends StatelessWidget {
  const DeleteMessagesBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
      listenWhen: (previous, current) =>
          current is DeleteLoading ||
          current is DeleteSuccess ||
          current is DeleteError,
      listener: (context, state) {
        state.whenOrNull(
          deleteLoading: () {},
          deleteSuccess: (data) {},
          deleteError: (message) {
            AppToast.show(
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
