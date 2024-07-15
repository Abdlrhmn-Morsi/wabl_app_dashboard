import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/helpers/spacing.dart';
import 'package:wabl_app_dashboard/core/widgets/app_global_app_bar.dart';
import 'package:wabl_app_dashboard/core/widgets/app_search.dart';
import 'package:wabl_app_dashboard/features/users/bloc_listeners/update_role_bloc_listener.dart';
import 'package:wabl_app_dashboard/features/users/logic/user_cubit.dart';
import '../../bottom_nav_bar/logic/bottom_nav_bar_cubit.dart';
import 'widgets/users_listView.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
    UserCubit.get.initData();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (v) {
        BottomNavBarCubit.get.changeIndex(0);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                //? Bloc Listeners
                const UpdateRoleBlocListener(),
                verticalSpace(20),
                AppGlobalAppBar(
                  title: 'Users',
                  isDefaultBackActive: false,
                  onTapBack: () {
                    BottomNavBarCubit.get.changeIndex(0);
                  },
                ),
                verticalSpace(20),
                AppSearch(
                  controller: UserCubit.get.searchController,
                  hint: 'Type User Email',
                  onTapSearch: () {
                    UserCubit.get.emitGetAllUsers(
                      isRefresh: true,
                    );
                  },
                ),
                verticalSpace(20),
                const Expanded(
                  child: UsersListView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
