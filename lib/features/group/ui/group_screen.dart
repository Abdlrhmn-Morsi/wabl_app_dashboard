// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wabl_app_dashboard/core/helpers/extensions.dart';
import 'package:wabl_app_dashboard/core/widgets/app_cach_image.dart';
import 'package:wabl_app_dashboard/core/widgets/app_empty_widget.dart';
import 'package:wabl_app_dashboard/core/widgets/post_btn.dart';
import 'package:wabl_app_dashboard/features/group/logic/group_state.dart';
import 'package:wabl_app_dashboard/features/group/ui/screens/add_group_screen.dart';

import '../../../core/helpers/app_size.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_global_app_bar.dart';
import '../../../core/widgets/app_read_more_text.dart';
import '../data/goup_model.dart';
import '../logic/group_cubit.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddOrEditBtn(
        icon: Icons.add,
        onTap: () {
          const AddGroupScreen().goOnWidget(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              verticalSpace(20),
              AppGlobalAppBar(title: 'groups'.tr(context: context)),
              verticalSpace(40),
              const GroupsListview(),
            ],
          ),
        ),
      ),
    );
  }
}

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

class GroupsListviewItem extends StatelessWidget {
  final GroupModel group;
  final void Function()? onTap;
  const GroupsListviewItem({
    super.key,
    required this.group,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          AppCachImage(
            image: group.avatar ?? "",
            isNotCircle: true,
            isNoBaseUrl: true,
            height: 60.w,
            width: 60.w,
          ),
          horizontalSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name ?? "",
                  style: TextStyles.font14Bold.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                verticalSpace(2),
                AppReadMoreText(
                  text: group.description ?? "",
                  style: TextStyles.font10GrayRegular.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
