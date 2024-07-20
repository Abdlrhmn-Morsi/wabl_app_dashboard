import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/app_images.dart';
import '../theming/colors.dart';
import 'app_cach_image.dart';

class AppImageHolder extends StatelessWidget {
  final double? height;
  final double? width;
  final File? chosenImage;
  final bool isCircle;
  final BoxFit? boxFit;
  final String? image;
  final bool isHolderImageAsset;
  const AppImageHolder({
    super.key,
    this.height,
    this.width,
    this.chosenImage,
    this.isCircle = false,
    this.boxFit,
    this.image,
    this.isHolderImageAsset = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: isCircle
          ? BorderRadius.circular(100)
          : BorderRadius.circular(
              8,
            ),
      child: Container(
        height: height?.w ?? 80.w,
        width: width?.w ?? 80.w,
        decoration: BoxDecoration(
          color: chosenImage != null
              ? ColorsManager.lightGray
              : ColorsManager.lighterGray,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: chosenImage != null
            ? Image.file(
                chosenImage ?? File(''),
                fit: boxFit,
              )
            : isHolderImageAsset
                ? Image.asset(
                    AppImages.placeholder,
                    fit: boxFit,
                  )
                : AppCachImage(
                    isNotCircle: !isCircle,
                    image: image ?? "",
                    width: width,
                    height: height,
                    boxFit: boxFit,
                    isNoBaseUrl: true,
                  ),
      ),
    );
  }
}
