import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/app_size.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../logic/login_cubit.dart';
import '../bloc_listeners/login_bloc_listener.dart';
import '../widgets/login_fields.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
                    const LoginBlocListener(),
                    //? logo
                    Image.asset(
                      AppImages.logoNameDashboard,
                      height: AppSize.fullHight(context) * .2,
                      width: AppSize.fullWidth(context) * .7,
                    ),

                    verticalSpace(16),
                    //? login form
                    const LogInFields(),
                    verticalSpace(16),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(Routes.forgetPasswordScreen);
                          },
                          child: Text(
                            'forget_password'.tr(),
                            style: TextStyles.font14GrayRegular,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(24),
                    AppTextButton(
                      buttonText: 'sign_in'.tr(),
                      textStyle: TextStyles.font14Bold,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          LoginCubit.get.emitLogin();
                        }
                      },
                    ),
                    verticalSpace(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'dont_have_an_account'.tr(),
                          style: TextStyles.font14GrayRegular,
                        ),
                        horizontalSpace(6),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(Routes.signUpScreen);
                          },
                          child: Text(
                            'sign_up'.tr(),
                            style: TextStyles.font14Bold.copyWith(
                              color: ColorsManager.mainBoldColor,
                            ),
                          ),
                        ),
                      ],
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
