import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/features/users/logic/role_cubit.dart';
import '../../../../core/helpers/app_size.dart';
import '../../../../core/widgets/app_alert_bottom_sheet.dart';
import '../../../../core/widgets/app_dashed_divider.dart';
import '../../../../core/widgets/app_pagination_loading_holder.dart';
import '../../logic/user_cubit.dart';
import '../../logic/user_state.dart';
import 'users_listview_item.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({super.key});

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // UserCubit.get.emitGetAllUsers();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        UserCubit.get.emitGetAllUsers(
          isPagination: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) =>
          current is Loading ||
          current is Success ||
          current is Error ||
          current is Pagination,
      builder: (context, state) {
        var cubit = UserCubit.get;
        return state is Loading
            ? const Center(child: CircularProgressIndicator())
            : cubit.isSearchResultEmpty()
                ? Center(
                    child: Text(
                    'not_found'.tr(context: context),
                  ))
                : RefreshIndicator(
                    onRefresh: () async {
                      await cubit.emitGetAllUsers(
                        isRefresh: true,
                      );
                    },
                    child: SizedBox(
                      height: AppSize.fullHight(context),
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: scrollController,
                        padding: EdgeInsets.only(bottom: 20.h),
                        shrinkWrap: true,
                        itemCount: cubit.usersList.length,
                        separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: const AppDividerDashed(),
                        ),
                        itemBuilder: (context, index) {
                          var user = cubit.usersList[index];
                          return AppPaginationLoadingHolder(
                            index: index,
                            isLoadingMore: cubit.isLoadingMore,
                            listLength: cubit.usersList.length,
                            isReachedEnd: cubit.isReachedEnd,
                            item: UsersListViewItem(
                              user: user,
                              onTap: () {
                                appAlertBottomSheet(
                                  context: context,
                                  message:
                                      '${user.name ?? ""}\n${'are_you_sure_you_want_to_hire_him_as_admin'.tr()}',
                                  onTapAction: () {
                                    RoleCubit.get
                                        .emitUpdateRole(
                                      userId: user.userId ?? "",
                                      role: 'admin',
                                    )
                                        .then((value) async {
                                      UserCubit.get.initData();
                                    });
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
      },
    );
  }
}
