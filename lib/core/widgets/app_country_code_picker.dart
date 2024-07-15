import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

class AppCountryCodePicker extends StatelessWidget {
  final String? ininValue;

  final void Function(CountryCode)? onChanged;
  const AppCountryCodePicker({
    super.key,
    this.onChanged,
    this.ininValue,
  });

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      searchDecoration: InputDecoration(
        prefixIconColor: AppColorsTheme.blackAndWhite(context),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColorsTheme.blackAndWhite(context),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).hintColor,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      boxDecoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      onChanged: onChanged,
      initialSelection: ininValue != null ? '+$ininValue' : 'EG',
      favorite: ininValue != null ? ['+$ininValue'] : const ['+2', 'EG'],
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
      flagWidth: 20.w,
    );
  }
}
