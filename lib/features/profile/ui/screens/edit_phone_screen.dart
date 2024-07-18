import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../logic/profile_cubit.dart';

class EditPhoneScreen extends StatefulWidget {
  final String phone;
  const EditPhoneScreen({super.key, required this.phone});

  @override
  State<EditPhoneScreen> createState() => _EditPhoneScreenState();
}

class _EditPhoneScreenState extends State<EditPhoneScreen> {
  var phoneTEC = TextEditingController();
  @override
  void initState() {
    super.initState();
    phoneTEC.text = widget.phone;
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
                          'update_phone'.tr(context: context),
                          maxLines: null,
                          textAlign: TextAlign.start,
                          style: TextStyles.font18Bold,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  AppTextField(
                    keyboardType: TextInputType.phone,
                    isNoBorder: true,
                    hintText: 'update_phone'.tr(context: context),
                    controller: phoneTEC,
                    validator: AppRegex.phoneNumberValidation,
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
                        ProfileCubit.get.emitUpdateUserInfo(
                          context: context,
                          phone: phoneTEC.text.trim(),
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
