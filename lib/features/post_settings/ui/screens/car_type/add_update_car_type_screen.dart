import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/helpers/extensions.dart';
import 'package:wabl_app_dashboard/core/theming/styles.dart';
import 'package:wabl_app_dashboard/features/post_settings/data/car_type_model.dart';
import 'package:wabl_app_dashboard/features/post_settings/logic/car_type_cubit.dart';
import '../../../../../core/helpers/app_regex.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/widgets/app_delete_alert_bottom_sheet.dart';
import '../../../../../core/widgets/app_text_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../bloc_listeners/cud_car_type_bloc_listener.dart';

class AddUpdateCarTypeScreen extends StatefulWidget {
  final CarTypeModel? carType;
  final bool isUpdate;
  const AddUpdateCarTypeScreen({
    super.key,
    this.carType,
    this.isUpdate = false,
  });

  @override
  State<AddUpdateCarTypeScreen> createState() => _AddUpdateCarTypeScreenState();
}

class _AddUpdateCarTypeScreenState extends State<AddUpdateCarTypeScreen> {
  var typeTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    typeTEC.text = widget.carType?.type ?? "";
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
                  const CarTypeBlocListner(),
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
                                      'are_you_sure_you_want_to_delete_this_car_type'
                                          .tr(),
                                  onTapAction: () {
                                    CarTypeCubit.get.emitDeleteCarType(
                                      id: widget.carType?.id ?? '',
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
                              ? "update_car_type".tr(context: context)
                              : 'create_car_type'.tr(context: context),
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
                    hintText: 'car_type'.tr(context: context),
                    controller: typeTEC,
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
                          CarTypeCubit.get.emitUpdateCarType(
                            type: typeTEC.text,
                            id: widget.carType?.id ?? "",
                          );
                        } else {
                          CarTypeCubit.get.emitCreateCarType(
                            type: typeTEC.text,
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
