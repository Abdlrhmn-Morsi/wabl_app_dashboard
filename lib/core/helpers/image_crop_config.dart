import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import '../theming/colors.dart';

class ImageCropHelper {
  static var aspectRatioPresets = [
    CropAspectRatioPreset.square,
    CropAspectRatioPreset.ratio3x2,
    CropAspectRatioPreset.original,
    CropAspectRatioPreset.ratio4x3,
    CropAspectRatioPreset.ratio16x9,
  ];
  static var uiSetting = [
    AndroidUiSettings(
      activeControlsWidgetColor: ColorsManager.mainColor,
      toolbarTitle: 'cropper',
      toolbarColor: Colors.black,
      toolbarWidgetColor: Colors.white,
      initAspectRatio: CropAspectRatioPreset.original,
      lockAspectRatio: false,
    ),
    IOSUiSettings(title: 'Cropper'),
  ];
  static Future<File?> cropImg({
    required File imageFile,
    CropStyle? cropStyle,
  }) async {
    CroppedFile? croppedImg = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      uiSettings: ImageCropHelper.uiSetting,
      aspectRatioPresets: ImageCropHelper.aspectRatioPresets,
      cropStyle: cropStyle ?? CropStyle.rectangle,
    );
    if (croppedImg == null) return null;
    return File(croppedImg.path);
  }
}
