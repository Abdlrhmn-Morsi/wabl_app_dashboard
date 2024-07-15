import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart.';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/widgets/app_country_code_picker.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../logic/signup_cubit.dart';
import '../../logic/signup_state.dart';

class PhoneWithCountryCode extends StatelessWidget {
  const PhoneWithCountryCode({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        var cubit = SignupCubit.get;
        return Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: cubit.phoneNumberTEC,
                keyboardType: TextInputType.number,
                hintText: 'phone number',
                isNoBorder: true,
                validator: AppRegex.phoneNumberValidation,
              ),
            ),
            AppCountryCodePicker(
              onChanged: (v) {
                var dialCode = v.dialCode ?? "+20";
                var countryCode = dialCode.replaceAll('+', '');
                cubit.countryCodeTEC.text = countryCode;
              },
            ),
          ],
        );
      },
    );
  }
}
