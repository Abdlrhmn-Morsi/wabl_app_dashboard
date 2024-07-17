import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_global_app_bar.dart';
import 'widgets/conversations_list_view.dart';

class AllConversationsScreen extends StatelessWidget {
  const AllConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              //? Bloc Listeners
              verticalSpace(20),
              AppGlobalAppBar(title: 'conversations'.tr(context: context)),
              verticalSpace(20),
              const ConversationsListView(),
            ],
          ),
        ),
      ),
    );
  }
}
