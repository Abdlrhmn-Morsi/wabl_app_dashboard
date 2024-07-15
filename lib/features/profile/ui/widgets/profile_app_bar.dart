import 'package:flutter/material.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/theming/styles.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox.shrink(),
        Text(
          'Profile Settings',
          style: TextStyles.font16Bold,
        ),
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Icon(Icons.close),
        ),
      ],
    );
  }
}
