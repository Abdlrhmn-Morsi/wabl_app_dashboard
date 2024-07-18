import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_global_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
                title: 'privacy_policy'.tr(context: context),
              ),
              verticalSpace(40),
              Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Text(
                    'Welcome to Wabl! Your privacy is important to us. We collect personal information such as your name, email, and phone number when you register, along with usage data and device information. This data helps us provide, maintain, and improve our services, personalize your experience, and communicate with you. We do not share your personal information with third parties, except with your consent, with service providers on our behalf, or to comply with legal obligations. We implement security measures to protect your information, though no method is completely secure. You can update or delete your personal information through your account settings or by contacting us at [insert contact email]. We may update this Privacy Policy, and your continued use of Wabl indicates your acceptance of any changes. If you have any questions, please contact us. Thank you for using Wabl!',
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
