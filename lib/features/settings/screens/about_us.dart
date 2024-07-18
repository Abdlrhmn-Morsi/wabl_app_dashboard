import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_global_app_bar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
                title: 'about_us'.tr(context: context),
              ),
              verticalSpace(40),
              Center(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Text(
                    'Welcome to Wabl, your go-to platform for posting and discovering ads! Whether you\'re looking to sell, buy, or advertise services, Wabl provides a simple and effective way for users to publish their ads and reach a wide audience. Our mission is to create a user-friendly space where you can easily connect with others and find what you need. Join our growing community and experience the convenience of Wabl for all your advertising needs. Thank you for choosing Wabl!',
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
