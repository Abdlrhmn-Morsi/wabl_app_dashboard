import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors.dart';
import '../../../logic/chat_cubit.dart';
import '../../../logic/chat_state.dart';

class SendBtn extends StatelessWidget {
  final void Function()? onTap;
  const SendBtn({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) => current is SendActive,
      builder: (context, state) {
        var cubit = ChatCubit.get;
        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: cubit.isSentActive
                  ? ColorsManager.mainColor
                  : ColorsManager.lightGray,
            ),
            child: Icon(
              Icons.send,
              size: 20.sp,
              color: cubit.isSentActive ? Colors.white : Colors.black,
            ),
          ),
        );
      },
    );
  }
}
