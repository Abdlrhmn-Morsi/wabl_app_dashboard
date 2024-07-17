import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/helpers/app_images.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/app_delete_alert_bottom_sheet.dart';
import '../../../../auth/logic/auth_helper.dart';
import '../../../data/models/message_response_body.dart';
import '../../../logic/chat_cubit.dart';
import '../../../logic/chat_state.dart';
import 'chat_messages_item.dart';

class ChatMessagesListview extends StatefulWidget {
  const ChatMessagesListview({
    super.key,
  });

  @override
  State<ChatMessagesListview> createState() => _ChatMessagesListviewState();
}

class _ChatMessagesListviewState extends State<ChatMessagesListview> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    ChatCubit.get.scrollController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChatCubit, ChatState>(
        buildWhen: (previous, current) =>
            current is SendLoading ||
            current is SendSuccess ||
            current is SendError ||
            current is chatLoading ||
            current is chatSuccess ||
            current is chatError,
        builder: (context, state) {
          var cubit = ChatCubit.get;
          return cubit.currentChatId.isEmpty
              ? const SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder<List<MessageResponseBody>>(
                          stream: cubit.getMessages(cubit.currentChatId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Text(
                                'error occured',
                                style: TextStyles.font12Bold,
                              );
                            }
                            var dataList = snapshot.data ?? [];
                            return ListView.separated(
                              controller: cubit.scrollController,
                              padding: EdgeInsets.only(bottom: 10.h),
                              reverse: true,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  verticalSpace(10),
                              itemCount: dataList.length,
                              itemBuilder: (context, index) {
                                var data = dataList[index];
                                return ChatMessagesItem(
                                  data: data,
                                  isMe: data.senderId == AuthHelper.userId(),
                                  onLongPress: () {
                                    if (data.isDeleted == true) return;
                                    appDeleteAlertBottomSheet(
                                      context: context,
                                      message:
                                          '${data.message} \n \n Are you sure u want to delete this message?',
                                      onTapAction: () {
                                        cubit.emitDeleteMessage(
                                          messageId: data.id ?? "",
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                      state is SendLoading
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Transform.scale(
                                scaleY: -1,
                                scaleX: -1,
                                child: Lottie.asset(
                                  AppImages.chatAnimation,
                                  height: 40.h,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
