import 'package:flutter/material.dart';
import 'package:wabl_app_dashboard/features/statistics/ui/statistics_screen.dart';
import 'package:wabl_app_dashboard/features/users/ui/widgets/employees_listview.dart';
import '../../../core/helpers/spacing.dart';
import '../../statistics/logic/statistics_cubit.dart';
import '../../users/bloc_listeners/update_role_bloc_listener.dart';
import '../../users/logic/employee_cubit.dart';
import 'widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        EmployeeCubit.get.emitGetAllEmployees(
          isPagination: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            StatisticsCubit.get.initStatistics(
              isRefresh: true,
            );
            EmployeeCubit.get.emitGetAllEmployees(
              isRefresh: true,
            );
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                //! bloc listeners
                const UpdateRoleBlocListener(),
                verticalSpace(10),
                const HomeAppBar(),
                verticalSpace(15),
                const StatisticsWidgets(),
                verticalSpace(15),
                //const CategoriesListview(),
                verticalSpace(10),
                // const PostsListview(),
                EmployeesListView(
                  scrollController: scrollController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
