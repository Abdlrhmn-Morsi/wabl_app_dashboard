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
import '../../logic/signup_cubit.dart';
import '../bloc_listeners/signup_bloc_listener.dart';
import '../widgets/sign_up_fields.dart';

class SignUpcreen extends StatefulWidget {
  const SignUpcreen({super.key});

  @override
  State<SignUpcreen> createState() => _SignUpcreenState();
}

class _SignUpcreenState extends State<SignUpcreen> {
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
                    const SignupBlocListener(),
                    //? logo
                    Image.asset(
                      AppImages.appIcon,
                      height: AppSize.fullHight(context) * .18,
                      width: AppSize.fullWidth(context) * .4,
                    ),
                    //? login form
                    const SignUpFields(),
                    verticalSpace(24),
                    //? login button
                    AppTextButton(
                      buttonText: 'create_account'.tr(),
                      textStyle: TextStyles.font14Bold,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          SignupCubit.get.emitSignUp();
                        }
                      },
                    ),
                    verticalSpace(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'already_have_an_account'.tr(),
                          style: TextStyles.font14GrayRegular,
                        ),
                        horizontalSpace(6),
                        GestureDetector(
                          onTap: () {
                            context.pushAndReplaceAllNamed(Routes.logInScreen);
                          },
                          child: Text(
                            'sign_in'.tr(),
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
