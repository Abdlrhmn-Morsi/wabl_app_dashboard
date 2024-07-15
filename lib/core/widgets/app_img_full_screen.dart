import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/app_size.dart';
import '../helpers/extensions.dart';
import 'app_cach_image.dart';

class AppImgFullScreen extends StatelessWidget {
  final String image;
  const AppImgFullScreen({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: image,
                child: InteractiveViewer(
                  child: AppCachImage(
                    borderRadius: BorderRadius.zero,
                    image: image,
                    boxFit: BoxFit.contain,
                    isNotCircle: true,
                    isNoBaseUrl: true,
                    width: AppSize.fullWidth(context),
                    height: AppSize.fullHight(context),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10.w,
              right: 10.w,
              top: 10.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
