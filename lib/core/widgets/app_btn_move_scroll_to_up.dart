import 'package:flutter/material.dart';
import '../theming/colors.dart';

class AppBtnMoveScrollToUp extends StatelessWidget {
  final ScrollController scrollController;
  const AppBtnMoveScrollToUp({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ColorsManager.thirdColor,
        ),
        child: const Icon(
          Icons.arrow_upward,
          color: Colors.white,
        ),
      ),
    );
  }
}
