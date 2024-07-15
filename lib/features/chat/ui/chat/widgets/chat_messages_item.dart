import 'package:flutter/material.dart';
import '../../../../../core/helpers/app_helper_functions.dart';
import '../../../../../core/helpers/app_size.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../data/models/message_response_body.dart';

class ChatMessagesItem extends StatelessWidget {
  final bool isMe;
  final MessageResponseBody data;
  final void Function()? onLongPress;
  const ChatMessagesItem({
    super.key,
    this.isMe = false,
    required this.data,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: UnconstrainedBox(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: isMe ? Radius.zero : const Radius.circular(10),
                topLeft: !isMe ? Radius.zero : const Radius.circular(10),
                bottomLeft: const Radius.circular(10),
                bottomRight: const Radius.circular(10),
              ),
              color: data.isDeleted == true
                  ? ColorsManager.gray
                  : isMe
                      ? AppColorsTheme.messageBgReciver(context)
                      : AppColorsTheme.messageBgSender(context),
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: AppSize.fullWidth(context) * .8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data.isDeleted == true
                            ? "This message has been deleted"
                            : data.message ?? "",
                        style: data.isDeleted == true
                            ? TextStyles.font10Bold.copyWith(
                                color: Colors.white,
                              )
                            : TextStyles.font14GrayRegular.copyWith(
                                color: isMe
                                    ? Colors.white
                                    : AppColorsTheme.blackAndWhiteSwitch(
                                        context,
                                      ),
                              ),
                        maxLines: null,
                      ),
                      verticalSpace(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data.createdAt == null
                                ? ''
                                : AppHelperFunctions.formatedDate(
                                    data.createdAt?.toDate(),
                                  ),
                            style: data.isDeleted == true
                                ? TextStyles.font10Bold.copyWith(
                                    color: Colors.white,
                                  )
                                : TextStyles.font10GrayRegular.copyWith(
                                    color: isMe
                                        ? Colors.white
                                        : AppColorsTheme.blackAndWhiteSwitch(
                                            context,
                                          ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
