import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/app_size.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../logic/forget_password_cubit.dart';
import '../../logic/forget_password_state.dart';
import '../bloc_listeners/forget_password_bloc_listener.dart';

class CheckResetCodeScreen extends StatefulWidget {
  const CheckResetCodeScreen({super.key});

  @override
  State<CheckResetCodeScreen> createState() => _CheckResetCodeScreenState();
}

class _CheckResetCodeScreenState extends State<CheckResetCodeScreen> {
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ForgetPasswordCubit.get.resetCodeTEC = TextEditingController();
  }

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
                      isCheckResetCode: true,
                    ),
                    //? logo
                    Image.asset(
                      AppImages.appIcon,
                      height: AppSize.fullHight(context) * .18,
                      width: AppSize.fullWidth(context) * .4,
                    ),
                    Text(
                      'Please enter Code send to this email',
                      style: TextStyles.font16Medium,
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace(5),
                    BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                      builder: (context, state) {
                        var cubit = ForgetPasswordCubit.get;
                        return Text(
                          cubit.emailTEC.text,
                          style: TextStyles.font16Bold,
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                    verticalSpace(24),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: PinCodeTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter code';
                          }
                          return null;
                        },
                        controller: ForgetPasswordCubit.get.resetCodeTEC,
                        length: 6,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: ColorsManager.mainBoldColor,
                        appContext: context,
                        obscureText: false,
                        showCursor: true,
                        keyboardType: TextInputType.number,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldHeight: 40,
                          fieldWidth: 40,
                          borderWidth: 1,
                          borderRadius: BorderRadius.circular(10),
                          selectedColor: ColorsManager.mainBoldColor,
                          selectedFillColor: Colors.white,
                          inactiveFillColor:
                              ColorsManager.mainBoldColor.withOpacity(0.1),
                          inactiveColor: ColorsManager.mainBoldColor,
                          activeColor: ColorsManager.mainBoldColor,
                          activeFillColor: ColorsManager.mainBoldColor,
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        onChanged: (v) {},
                        beforeTextPaste: (text) {
                          return true;
                        },
                      ),
                    ),
                    verticalSpace(16),
                    AppTextButton(
                      buttonText: 'Confirm',
                      textStyle: TextStyles.font14Bold,
                      onPressed: () {
                        context.pushNamed(Routes.resetPasswordScreen);

                        // if (formKey.currentState!.validate()) {
                        //   //context.pushNamed(Routes.resetPasswordScreen);
                        //   ForgetPasswordCubit.get.emitCheckResetCode();
                        // }
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
