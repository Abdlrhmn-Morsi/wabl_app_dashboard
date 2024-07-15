import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../logic/chat_cubit.dart';
// import 'message_img.dart';
import 'send_btn.dart';

class ChatTextFieldWithActions extends StatelessWidget {
  final String receiverId;
  const ChatTextFieldWithActions({
    super.key,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 15.w,
          ),
          child: Row(
            children: [
              //  const MessageImg(),
              Expanded(
                child: Scrollbar(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 5 * (14 + 10),
                    ),
                    child: AppTextField(
                      controller: ChatCubit.get.messageTEC,
                      // suffixIcon: const SendImgBtn(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      textStyle: TextStyle(fontSize: 14.sp),
                      hintText: 'Message',
                      isNoBorder: true,
                      isDense: true,
                      isMultibleLines: true,
                      onChanged: (v) {
                        ChatCubit.get.getIsSentActive(v.isNotEmpty);
                      },
                      validator: (v) {
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              horizontalSpace(10),
              SendBtn(
                onTap: () {
                  ChatCubit.get.sendMessage(receiverId: receiverId);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
