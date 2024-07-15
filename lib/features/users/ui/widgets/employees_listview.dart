import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_alert_bottom_sheet.dart';
import '../../../../core/widgets/app_dashed_divider.dart';
import '../../../../core/widgets/app_pagination_loading_holder.dart';
import '../../../../core/widgets/app_text_with_action.dart';
import '../../logic/employee_cubit.dart';
import '../../logic/employee_state.dart';
import '../../logic/role_cubit.dart';
import 'employees_listview_item.dart';

class EmployeesListView extends StatefulWidget {
  final ScrollController scrollController;
  const EmployeesListView({
    super.key,
    required this.scrollController,
  });

  @override
  State<EmployeesListView> createState() => _EmployeesListViewState();
}

class _EmployeesListViewState extends State<EmployeesListView> {
  @override
  void initState() {
    super.initState();
    EmployeeCubit.get.emitGetAllEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          const AppTextWithAction(text: 'Employees'),
          verticalSpace(14),
          BlocBuilder<EmployeeCubit, EmployeeState>(
            buildWhen: (previous, current) =>
                current is Loading ||
                current is Success ||
                current is Error ||
                current is Fresh ||
                current is Pagination,
            builder: (context, state) {
              var cubit = EmployeeCubit.get;
              return state is Loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      shrinkWrap: true,
                      controller: widget.scrollController,
                      padding: EdgeInsets.only(bottom: 20.h),
                      itemCount: cubit.employeesList.length,
                      separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: const AppDividerDashed(),
                      ),
                      itemBuilder: (context, index) {
                        var user = cubit.employeesList[index];
                        return AppPaginationLoadingHolder(
                          index: index,
                          isLoadingMore: cubit.isLoadingMore,
                          listLength: cubit.employeesList.length,
                          isReachedEnd: cubit.isReachedEnd,
                          item: EmployeesListViewItem(
                            user: user,
                            onTap: () {
                              appAlertBottomSheet(
                                context: context,
                                message:
                                    'Are you sure u want to Remove this Employee?',
                                onTapAction: () {
                                  RoleCubit.get
                                      .emitUpdateRole(
                                    userId: user.userId ?? "",
                                    role: 'user',
                                  )
                                      .then((value) async {
                                    await EmployeeCubit.get.emitGetAllEmployees(
                                      isRefresh: true,
                                      isLoadingActive: false,
                                    );
                                  });
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
