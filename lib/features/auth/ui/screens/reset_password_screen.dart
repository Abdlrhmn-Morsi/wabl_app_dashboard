import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/app_size.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_password_text_field.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../logic/forget_password_cubit.dart';
import '../bloc_listeners/forget_password_bloc_listener.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  void initState() {
    super.initState();
  }

  var newPasswordTEC = TextEditingController();
  var confirmPasswordTEC = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          child: Center(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //? login listener
                  const ForgetPasswordBlocListener(
                    isResetPassword: true,
                  ),
                  //? logo
                  Image.asset(
                    AppImages.appIcon,
                    height: AppSize.fullHight(context) * .18,
                    width: AppSize.fullWidth(context) * .4,
                  ),
                  Text(
                    'Please enter your new password!',
                    style: TextStyles.font16Medium.copyWith(height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(24),
                  AppPasswordTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: newPasswordTEC,
                    hintText: 'New Password',
                    isNoBorder: true,
                    validator: AppRegex.passwordValidation,
                  ),
                  verticalSpace(16),
                  AppPasswordTextField(
                    controller: confirmPasswordTEC,
                    hintText: 'Confirm Password',
                    isNoBorder: true,
                    validator: (value) {
                      return AppRegex.confirmationPasswordValidation(
                        confirmPassword: value,
                        password: newPasswordTEC.text,
                      );
                    },
                  ),
                  verticalSpace(16),
                  AppTextButton(
                    buttonText: 'Reset Password',
                    textStyle: TextStyles.font14Bold,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ForgetPasswordCubit.get.emitResetPassword(
                          newPassword: newPasswordTEC.text,
                          confirmPassword: confirmPasswordTEC.text,
                        );
                      }
                    },
                  ),
                  verticalSpace(16),
                  GestureDetector(
                    onTap: () {
                      context.pushAndReplaceAllNamed(Routes.logInScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign in',
                          style: TextStyles.font14Bold,
                        ),
                        horizontalSpace(5),
                        const Icon(
                          Icons.arrow_right_alt_sharp,
                          color: ColorsManager.mainColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
