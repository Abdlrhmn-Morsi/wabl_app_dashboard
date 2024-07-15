import 'package:flutter/material.dart';

import '../helpers/app_images.dart';
import '../helpers/app_size.dart';
import '../helpers/spacing.dart';

class AppEmptyWidget extends StatelessWidget {
  final String? text;
  const AppEmptyWidget({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppImages.empty,
          height: AppSize.fullHight(context) * .12,
        ),
        verticalSpace(12),
        Text(
          text ?? 'Empty',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
