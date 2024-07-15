import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_size.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_country_code_picker.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../logic/profile_cubit.dart';

class EditCountryCodeScreen extends StatefulWidget {
  final String countryCode;
  const EditCountryCodeScreen({super.key, required this.countryCode});

  @override
  State<EditCountryCodeScreen> createState() => _EditCountryCodeScreenState();
}

class _EditCountryCodeScreenState extends State<EditCountryCodeScreen> {
  var countryCode = '20';
  @override
  void initState() {
    super.initState();
    countryCode = widget.countryCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Update Your Country Code',
                        maxLines: null,
                        textAlign: TextAlign.start,
                        style: TextStyles.font18Bold,
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
                Container(
                  width: AppSize.fullWidth(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: AppCountryCodePicker(
                    ininValue: widget.countryCode,
                    onChanged: (v) {
                      var code = v.dialCode ?? "20";
                      countryCode = code.replaceAll('+', '');
                    },
                  ),
                ),
                verticalSpace(20),
                AppTextButton(
                  verticalPadding: 8,
                  buttonHeight: 40.h,
                  borderRadius: 8.r,
                  buttonText: 'Update',
                  textStyle: TextStyles.font14Bold,
                  onPressed: () {
                    ProfileCubit.get.emitUpdateUserInfo(
                      context: context,
                      countryCode: countryCode,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
