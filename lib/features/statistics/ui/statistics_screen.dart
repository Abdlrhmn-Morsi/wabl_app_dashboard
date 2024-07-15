import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/widgets/app_text_with_action.dart';
import 'package:wabl_app_dashboard/features/statistics/logic/statistics_cubit.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../logic/statistics_state.dart';

class StatisticsWidgets extends StatefulWidget {
  const StatisticsWidgets({super.key});

  @override
  State<StatisticsWidgets> createState() => _StatisticsWidgetsState();
}

class _StatisticsWidgetsState extends State<StatisticsWidgets> {
  @override
  void initState() {
    super.initState();
    StatisticsCubit.get.initStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      buildWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      builder: (context, state) {
        var cubit = StatisticsCubit.get;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              verticalSpace(10),
              const AppTextWithAction(text: 'Users'),
              verticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatisticsItem(
                    title: 'Total Users',
                    num: cubit.usersCount.toString(),
                  ),
                  horizontalSpace(10),
                  StatisticsItem(
                    title: 'Employees',
                    num: cubit.employeesCount.toString(),
                  ),
                ],
              ),
              verticalSpace(10),
              const AppTextWithAction(text: 'Posts'),
              verticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatisticsItem(
                    title: 'All',
                    num: cubit.totalPosts.toString(),
                  ),
                  horizontalSpace(10),
                  StatisticsItem(
                    title: 'Approved',
                    num: cubit.approvedPosts.toString(),
                  ),
                  horizontalSpace(10),
                  StatisticsItem(
                    title: 'Pending',
                    num: cubit.pendingPosts.toString(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class StatisticsItem extends StatelessWidget {
  final String title;
  final String num;
  const StatisticsItem({
    super.key,
    required this.title,
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 20.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColorsTheme.onBackground(context),
          boxShadow: [
            BoxShadow(
              color: AppColorsTheme.blackAndWhite(context).withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.font14Bold,
            ),
            verticalSpace(10),
            Text(
              num,
              style: TextStyles.font24Bold,
            ),
          ],
        ),
      ),
    );
  }
}
