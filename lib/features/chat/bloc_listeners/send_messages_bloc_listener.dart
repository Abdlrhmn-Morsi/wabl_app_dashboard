import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/app_toast.dart';
import '../logic/chat_cubit.dart';
import '../logic/chat_state.dart';

class SendMessagesBlocListener extends StatelessWidget {
  const SendMessagesBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
      listenWhen: (previous, current) =>
          current is SendLoading ||
          current is SendSuccess ||
          current is SendError,
      listener: (context, state) {
        state.whenOrNull(
          sendLoading: () {
            ChatCubit.get.getIsSentActive(false);
          },
          sendSuccess: (data) {},
          sendError: (message) {
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
