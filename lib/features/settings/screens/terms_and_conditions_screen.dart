import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_global_app_bar.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              verticalSpace(20),
              AppGlobalAppBar(
                title: 'terms_and_conditions'.tr(context: context),
              ),
              verticalSpace(40),
              Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Text(
                    'By using the Wabl app, you agree to comply with these Terms and Conditions. You are responsible for maintaining the confidentiality of your account information and for all activities under your account. You agree not to use Wabl for any unlawful or prohibited activities. We reserve the right to terminate or suspend your access to Wabl at our discretion. Wabl is provided "as is" without warranties of any kind. We are not liable for any damages arising from your use of Wabl. These Terms and Conditions may be updated, and your continued use of Wabl indicates your acceptance of any changes. If you have any questions, please contact us at wabl@wabl. Thank you for using Wabl!',
                    style: TextStyles.font14Medium.copyWith(
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
