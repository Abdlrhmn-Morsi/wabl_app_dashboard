import 'package:flutter/material.dart';
import '../../../../core/helpers/spacing.dart';
import '../../bloc_listeners/delete_message_bloc_listener.dart';
import '../../bloc_listeners/send_messages_bloc_listener.dart';
import '../../data/models/chat_response_body.dart';
import '../../logic/chat_cubit.dart';
import 'widgets/chat_app_bar.dart';
import 'widgets/chat_messages_list_view.dart';
import 'widgets/chat_text_field_with_actions.dart';

class ChatScreen extends StatefulWidget {
  final ChatWith chatWith;
  final String? chatId;

  const ChatScreen({
    super.key,
    required this.chatWith,
    this.chatId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.chatId == null) {
      ChatCubit.get.initiateChat(widget.chatWith.id ?? "");
    } else {
      ChatCubit.get.getChatId(id: widget.chatId ?? "");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //? bloc linteners
            const SendMessagesBlocListener(),
            const DeleteMessagesBlocListener(),
            Column(
              children: [
                verticalSpace(20),
                ChatAppBar(
                  chatWith: widget.chatWith,
                ),
                verticalSpace(10),
              ],
            ),
            const ChatMessagesListview(),
            ChatTextFieldWithActions(
              receiverId: widget.chatWith.id ?? "",
            ),
          ],
        ),
      ),
    );
  }
}
