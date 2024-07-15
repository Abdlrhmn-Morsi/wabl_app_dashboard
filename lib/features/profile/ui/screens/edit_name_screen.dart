import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../logic/profile_cubit.dart';

class EditNameScreen extends StatefulWidget {
  final String name;
  const EditNameScreen({
    super.key,
    required this.name,
  });

  @override
  State<EditNameScreen> createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  var nameTEC = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameTEC.text = widget.name;
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
                          'Update Your Name',
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
                    hintText: 'update your name',
                    controller: nameTEC,
                    validator: AppRegex.checkFullName,
                  ),
                  verticalSpace(20),
                  AppTextButton(
                    verticalPadding: 8,
                    buttonHeight: 40.h,
                    borderRadius: 8.r,
                    buttonText: 'Update',
                    textStyle: TextStyles.font14Bold,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ProfileCubit.get.emitUpdateUserInfo(
                          context: context,
                          name: nameTEC.text,
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
