import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/helpers/extensions.dart';
import '../../../../../../core/helpers/app_size.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/widgets/app_empty_widget.dart';
import '../../../../logic/manufacture_year_cubit.dart';
import '../../../../logic/manufacture_year_state.dart';
import '../add_update_manufacture_year_screen.dart';
import 'manufacturer_year_listview_item.dart';

class ManufacturerYearListview extends StatefulWidget {
  const ManufacturerYearListview({super.key});

  @override
  State<ManufacturerYearListview> createState() =>
      _ManufacturerYearListviewState();
}

class _ManufacturerYearListviewState extends State<ManufacturerYearListview> {
  var scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    ManufactureYearCubit.get.emitGetAllManufactureYear();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        ManufactureYearCubit.get.emitGetAllManufactureYear(
          isPagination: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManufactureYearCubit, ManufactureYearState>(
      buildWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      builder: (context, state) {
        var cubit = ManufactureYearCubit.get;
        return Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await cubit.emitGetAllManufactureYear(isRefresh: true);
            },
            child: SizedBox(
              height: AppSize.fullHight(context),
              child: state is Loading
                  ? const Center(child: CircularProgressIndicator())
                  : cubit.manufactureYearList.isEmpty
                      ? Center(
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: AppEmptyWidget(
                              text: 'no_manufacture_year'.tr(context: context),
                            ),
                          ),
                        )
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 20.h),
                          separatorBuilder: (_, i) => verticalSpace(12),
                          itemCount: cubit.manufactureYearList.length,
                          itemBuilder: (_, i) {
                            var manufactureYear = cubit.manufactureYearList[i];
                            return ManufacturerYearListviewItem(
                              manufactureYear: manufactureYear,
                              onTap: () {
                                AddUpdateManufactureYearScreen(
                                  isUpdate: true,
                                  manufactureYear: manufactureYear,
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
