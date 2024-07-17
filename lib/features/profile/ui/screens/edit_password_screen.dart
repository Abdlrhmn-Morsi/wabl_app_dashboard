import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_password_text_field.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../logic/update_password_cubit.dart';
import '../bloc_listeners/update_password_bloc_listener.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  var oldPasswordTEC = TextEditingController();
  var newPasswordTEC = TextEditingController();
  var newPasswordConfirmationTEC = TextEditingController();

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
                  //? UpdatePasswordBlocListener
                  const UpdatePasswordBlocListener(),

                  verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'update_password'.tr(context: context),
                          maxLines: null,
                          textAlign: TextAlign.start,
                          style: TextStyles.font18Bold,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  AppPasswordTextField(
                    controller: oldPasswordTEC,
                    isNoBorder: true,
                    hintText: 'current_password'.tr(context: context),
                    validator: AppRegex.passwordValidation,
                  ),
                  verticalSpace(20),
                  AppPasswordTextField(
                    controller: newPasswordTEC,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    isNoBorder: true,
                    hintText: 'new_password'.tr(context: context),
                    validator: AppRegex.passwordValidation,
                  ),
                  verticalSpace(20),
                  AppPasswordTextField(
                    controller: newPasswordConfirmationTEC,
                    isNoBorder: true,
                    hintText: 'confirm_password'.tr(context: context),
                    validator: (v) {
                      return AppRegex.confirmationPasswordValidation(
                        password: newPasswordTEC.text,
                        confirmPassword: v,
                      );
                    },
                  ),
                  verticalSpace(20),
                  AppTextButton(
                    verticalPadding: 8,
                    buttonHeight: 40.h,
                    borderRadius: 8.r,
                    buttonText: 'update'.tr(context: context),
                    textStyle: TextStyles.font14Bold,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        UpdatePasswordCubit.get.emitUpdatePassword(
                          oldPassword: oldPasswordTEC.text.trim(),
                          newPassword: newPasswordTEC.text.trim(),
                          newPasswordConfirmation:
                              newPasswordConfirmationTEC.text.trim(),
                        );
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
