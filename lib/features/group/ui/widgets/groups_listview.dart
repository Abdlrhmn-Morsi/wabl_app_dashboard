import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/helpers/extensions.dart';

import '../../../../core/helpers/app_size.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_empty_widget.dart';
import '../../logic/group_cubit.dart';
import '../../logic/group_state.dart';
import '../screens/add_group_screen.dart';
import 'groups_listview_item.dart';

class GroupsListview extends StatefulWidget {
  const GroupsListview({super.key});

  @override
  State<GroupsListview> createState() => _GroupsListviewState();
}

class _GroupsListviewState extends State<GroupsListview> {
  var scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    GroupCubit.get.emitGetAllGroups();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        GroupCubit.get.emitGetAllGroups(
          isPagination: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupState>(
      buildWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      builder: (context, state) {
        var cubit = GroupCubit.get;
        return Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await cubit.emitGetAllGroups(isRefresh: true);
            },
            child: SizedBox(
              height: AppSize.fullHight(context),
              child: state is Loading
                  ? const Center(child: CircularProgressIndicator())
                  : cubit.groupsList.isEmpty
                      ? Center(
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: AppEmptyWidget(
                              text: 'no_groups'.tr(context: context),
                            ),
                          ),
                        )
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 20.h),
                          separatorBuilder: (_, i) => verticalSpace(20),
                          itemCount: cubit.groupsList.length,
                          itemBuilder: (_, i) {
                            var group = cubit.groupsList[i];
                            return GroupsListviewItem(
                              group: group,
                              onTap: () {
                                AddGroupScreen(
                                  isUpdate: true,
                                  group: group,
                                ).goOnWidget(context);
                              },
                            );
                          },
                        ),
            ),
          ),
        );
      },
    );
  }
}
