import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/helpers/extensions.dart';
import 'package:wabl_app_dashboard/features/post_settings/logic/car_type_cubit.dart';
import 'package:wabl_app_dashboard/features/post_settings/logic/car_type_state.dart';
import '../../../../../../core/helpers/app_size.dart';
import '../../../../../../core/helpers/spacing.dart';
import '../../../../../../core/widgets/app_empty_widget.dart';
import '../add_update_car_type_screen.dart';
import 'car_type_listview_item.dart';

class CarTypeListview extends StatefulWidget {
  const CarTypeListview({super.key});

  @override
  State<CarTypeListview> createState() => _CarTypeListviewState();
}

class _CarTypeListviewState extends State<CarTypeListview> {
  var scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    CarTypeCubit.get.emitGetAllCarTypes();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        CarTypeCubit.get.emitGetAllCarTypes(
          isPagination: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarTypeCubit, CarTypeState>(
      buildWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      builder: (context, state) {
        var cubit = CarTypeCubit.get;
        return Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await cubit.emitGetAllCarTypes(isRefresh: true);
            },
            child: SizedBox(
              height: AppSize.fullHight(context),
              child: state is Loading
                  ? const Center(child: CircularProgressIndicator())
                  : cubit.carTypesList.isEmpty
                      ? Center(
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: AppEmptyWidget(
                              text: 'no_car_types'.tr(context: context),
                            ),
                          ),
                        )
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 20.h),
                          separatorBuilder: (_, i) => verticalSpace(12),
                          itemCount: cubit.carTypesList.length,
                          itemBuilder: (_, i) {
                            var carTyp = cubit.carTypesList[i];
                            return CarTypeListviewItem(
                              carTyp: carTyp,
                              onTap: () {
                                AddUpdateCarTypeScreen(
                                  isUpdate: true,
                                  carType: carTyp,
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
