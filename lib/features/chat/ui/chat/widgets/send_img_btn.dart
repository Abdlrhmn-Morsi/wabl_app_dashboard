import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../logic/chat_cubit.dart';

class SendImgBtn extends StatelessWidget {
  const SendImgBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ChatCubit.get.selectMessageImg();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.image,
          size: 20.sp,
        ),
      ),
    );
  }
}
