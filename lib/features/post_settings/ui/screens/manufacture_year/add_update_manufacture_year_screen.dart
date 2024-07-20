import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/helpers/extensions.dart';
import 'package:wabl_app_dashboard/core/theming/styles.dart';
import 'package:wabl_app_dashboard/features/post_settings/bloc_listeners/cud_manufacure_year_bloc_listener.dart';
import 'package:wabl_app_dashboard/features/post_settings/logic/manufacture_year_cubit.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/widgets/app_delete_alert_bottom_sheet.dart';
import '../../../../../core/widgets/app_text_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../data/manufacture_year_model.dart';

class AddUpdateManufactureYearScreen extends StatefulWidget {
  final ManufactureYearModel? manufactureYear;
  final bool isUpdate;
  const AddUpdateManufactureYearScreen({
    super.key,
    this.manufactureYear,
    this.isUpdate = false,
  });

  @override
  State<AddUpdateManufactureYearScreen> createState() =>
      _AddUpdateManufactureYearScreenState();
}

class _AddUpdateManufactureYearScreenState
    extends State<AddUpdateManufactureYearScreen> {
  var yearTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    yearTEC.text = widget.manufactureYear?.year ?? "";
  }

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  //? Bloc Listners
                  const CudManufacureYearBlocListner(),
                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: const Icon(Icons.close),
                      ),
                      !widget.isUpdate
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onTap: () {
                                appDeleteAlertBottomSheet(
                                  context: context,
                                  message:
                                      'are_you_sure_you_want_to_delete_this_manufacture_year'
                                          .tr(),
                                  onTapAction: () {
                                    ManufactureYearCubit.get
                                        .emitDeleteManufactureYear(
                                      manufactureYearId:
                                          widget.manufactureYear?.id ?? '',
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                Icons.delete_forever_rounded,
                                color: Colors.red,
                                size: 30.sp,
                              ),
                            ),
                    ],
                  ),
                  verticalSpace(20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.isUpdate
                              ? "update_manufacture_year".tr(context: context)
                              : 'add_manufacture_year'.tr(context: context),
                          maxLines: null,
                          textAlign: TextAlign.start,
                          style: TextStyles.font18Bold,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  AppTextField(
                    isNoBorder: true,
                    hintText: 'manufacture_year'.tr(context: context),
                    controller: yearTEC,
                    validator: AppRegex.checkNotEmpty,
                  ),
                  verticalSpace(20),
                  AppTextButton(
                    verticalPadding: 8,
                    buttonHeight: 40.h,
                    borderRadius: 8.r,
                    buttonText: widget.isUpdate
                        ? 'update'.tr(context: context)
                        : 'create'.tr(context: context),
                    textStyle: TextStyles.font14Bold,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (widget.isUpdate) {
                          ManufactureYearCubit.get.emitUpdateManufactureYear(
                            year: yearTEC.text,
                            manufactureYearId: widget.manufactureYear?.id ?? "",
                          );
                        } else {
                          ManufactureYearCubit.get.emitCreateManufactureYear(
                            year: yearTEC.text,
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
