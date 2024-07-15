import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../logic/chat_cubit.dart';
import '../../../logic/chat_state.dart';

class MessageImg extends StatelessWidget {
  const MessageImg({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) => current is SelectMessageImg,
      builder: (context, state) {
        var cubit = ChatCubit.get;
        return cubit.messageImg == null
            ? const SizedBox.shrink()
            : Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          height: 50.w,
                          width: 50.w,
                          child: Image.file(
                            cubit.messageImg ?? File(''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            cubit.clearMessageImg();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  AppColorsTheme.blackAndWhiteSwitch(context),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 16.sp,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  horizontalSpace(10),
                ],
              );
      },
    );
  }
}
