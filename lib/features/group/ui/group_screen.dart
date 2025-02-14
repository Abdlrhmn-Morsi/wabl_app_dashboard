// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/helpers/extensions.dart';
import 'package:wabl_app_dashboard/core/widgets/post_btn.dart';
import 'package:wabl_app_dashboard/features/group/ui/screens/add_group_screen.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/widgets/app_global_app_bar.dart';
import 'widgets/groups_listview.dart';

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
