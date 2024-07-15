import 'package:flutter/material.dart';
import '../helpers/spacing.dart';
import '../theming/styles.dart';

class AppPaginationLoadingHolder extends StatelessWidget {
  final int index;
  final int listLength;
  final bool isLoadingMore;
  final bool isReachedEnd;
  final Widget item;
  final double? topSpace;
  final double? bottomSpace;
  final CrossAxisAlignment? crossAxisAlignment;
  const AppPaginationLoadingHolder({
    super.key,
    required this.index,
    required this.listLength,
    required this.isLoadingMore,
    required this.item,
    this.topSpace,
    this.bottomSpace,
    required this.isReachedEnd,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        item,
        if (!isReachedEnd && index == listLength - 1 && isLoadingMore) ...[
          verticalSpace(topSpace ?? 20),
          const CircularProgressIndicator(),
          verticalSpace(bottomSpace ?? 20),
        ],
        if (isReachedEnd && index == listLength - 1) ...[
          verticalSpace(topSpace ?? 40),
          Text(
            'No more data available',
            style: TextStyles.font10GrayRegular,
          ),
          verticalSpace(bottomSpace ?? 20),
        ],
      ],
    );
  }
}
