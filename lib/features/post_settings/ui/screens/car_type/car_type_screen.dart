import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/helpers/extensions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/widgets/app_global_app_bar.dart';
import '../../../../../core/widgets/post_btn.dart';
import 'add_update_car_type_screen.dart';
import 'widgets/car_type_listview.dart';

class CarTypeScreen extends StatelessWidget {
  const CarTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddOrEditBtn(
        icon: Icons.add,
        onTap: () {
          const AddUpdateCarTypeScreen().goOnWidget(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              verticalSpace(20),
              AppGlobalAppBar(title: 'car_type'.tr(context: context)),
              verticalSpace(40),
              const CarTypeListview(),
            ],
          ),
        ),
      ),
    );
  }
}
