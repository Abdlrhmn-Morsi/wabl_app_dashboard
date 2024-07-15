import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/app_size.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../logic/forget_password_cubit.dart';
import '../bloc_listeners/reset_password_firebase_bloc_listener.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formkey,
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
                    // const ForgetPasswordBlocListener(
                    //   isFogetPassword: true,
                    // ),
                    const ResetPasswordFirebaseBlocListener(),
                    //? logo
                    Image.asset(
                      AppImages.appIcon,
                      height: AppSize.fullHight(context) * .18,
                      width: AppSize.fullWidth(context) * .4,
                    ),
                    Text(
                      'Please enter your email to get reset link',
                      style: TextStyles.font14Medium.copyWith(height: 1.4),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace(24),
                    AppTextField(
                      controller: ForgetPasswordCubit.get.emailTEC,
                      hintText: 'Email Adress',
                      isNoBorder: true,
                      validator: AppRegex.emailValidation,
                    ),
                    verticalSpace(16),
                    AppTextButton(
                      buttonText: 'Confirm',
                      textStyle: TextStyles.font14Bold,
                      onPressed: () {
                        // context.pushNamed(Routes.checkResetCodeScreen);
                        if (formkey.currentState!.validate()) {
                          ForgetPasswordCubit.get.emitResetPasswordFirebase();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
