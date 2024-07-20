import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wabl_app_dashboard/core/theming/colors.dart';
import 'package:wabl_app_dashboard/core/widgets/app_global_app_bar.dart';
import 'package:wabl_app_dashboard/core/widgets/app_text_button.dart';
import 'package:wabl_app_dashboard/core/widgets/app_text_field.dart';
import 'package:wabl_app_dashboard/core/widgets/app_text_with_action.dart';
import 'package:wabl_app_dashboard/features/group/data/goup_model.dart';
import 'package:wabl_app_dashboard/features/group/logic/create_group_cubit.dart';
import 'package:wabl_app_dashboard/features/group/logic/create_group_state.dart';
import '../../../../core/helpers/app_size.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_image_holder.dart';
import '../../bloc_liteners/create_group_bloc_listener.dart';

class AddGroupScreen extends StatefulWidget {
  final bool isUpdate;
  final GroupModel? group;
  const AddGroupScreen({
    super.key,
    this.isUpdate = false,
    this.group,
  });

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    CreateGroupCubit.get.initData(widget.group);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BlocBuilder<CreateGroupCubit, CreateGroupState>(
              buildWhen: (previous, current) => current is SelectImage,
              builder: (context, state) {
                var cubit = CreateGroupCubit.get;
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      //? Bloc Listeners
                      CreateGroupBlocListener(
                        isUpdate: widget.isUpdate,
                      ),
                      verticalSpace(20),
                      AppGlobalAppBar(
                          title: widget.isUpdate
                              ? 'update_group'.tr(context: context)
                              : 'add_group'.tr(context: context)),
                      verticalSpace(20),
                      AppTextWithAction(
                        text: 'cover'.tr(context: context),
                      ),
                      verticalSpace(10),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.getGroupCover();
                            },
                            child: AppImageHolder(
                              height: AppSize.fullHight(context) * .17,
                              width: AppSize.fullWidth(context),
                              boxFit: BoxFit.cover,
                              chosenImage: cubit.groupCover,
                              image: widget.group?.cover ?? "",
                            ),
                          ),
                          cubit.groupCover == null
                              ? const SizedBox.shrink()
                              : Positioned(
                                  top: 5.h,
                                  right: 5.w,
                                  child: GestureDetector(
                                    onTap: () {
                                      cubit.removeImg();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: AppColorsTheme.blackAndWhite(
                                            context),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 18.sp,
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                      verticalSpace(20),
                      AppTextWithAction(
                        text: 'avatar'.tr(context: context),
                      ),
                      verticalSpace(10),
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.getGroupAvatar();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: AppImageHolder(
                                width: 100.w,
                                height: 100.w,
                                boxFit: BoxFit.cover,
                                isCircle: true,
                                chosenImage: cubit.groupAvatar,
                                image: widget.group?.avatar ?? "",
                              ),
                            ),
                          ),
                          cubit.groupAvatar == null
                              ? const SizedBox.shrink()
                              : Positioned(
                                  top: 10.h,
                                  child: GestureDetector(
                                    onTap: () {
                                      cubit.removeImg(isAvatar: true);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: AppColorsTheme.blackAndWhite(
                                            context),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 18.sp,
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                      verticalSpace(20),
                      AppTextWithAction(
                        text: 'group_name'.tr(context: context),
                      ),
                      verticalSpace(10),
                      AppTextField(
                        controller: CreateGroupCubit.get.nameTEC,
                        isNoBorder: true,
                        hintText: 'group_name'.tr(context: context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'required_field'.tr(context: context);
                          }
                          return null;
                        },
                      ),
                      verticalSpace(20),
                      AppTextWithAction(
                        text: 'group_description'.tr(context: context),
                      ),
                      verticalSpace(10),
                      AppTextField(
                        controller: CreateGroupCubit.get.descriptionTEC,
                        isNoBorder: true,
                        hintText: 'group_description'.tr(context: context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'required_field'.tr(context: context);
                          }
                          return null;
                        },
                      ),
                      verticalSpace(20),
                      AppTextButton(
                        buttonText:
                            widget.isUpdate ? 'update'.tr() : 'create'.tr(),
                        textStyle: TextStyles.font14Medium,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.isUpdate) {
                              CreateGroupCubit.get.emitUpdateGroup();
                            } else {
                              CreateGroupCubit.get.emitCreateGroup();
                            }
                          }
                        },
                      ),
                      verticalSpace(20),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
