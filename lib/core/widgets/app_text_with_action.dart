import 'package:flutter/material.dart';

import '../theming/styles.dart';

class AppTextWithAction extends StatelessWidget {
  final String text;
  const AppTextWithAction({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyles.font16Bold,
        ),
        const Icon(Icons.more_horiz),
      ],
    );
  }
}
