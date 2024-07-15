import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_text_field.dart';

class AppPasswordTextField extends StatefulWidget {
  final AutovalidateMode? autovalidateMode;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final bool isMultibleLines;
  final int maxLines;
  final String? hintText;
  final bool? isDense;
  final TextAlign? textAlign;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final void Function(PointerDownEvent)? onTapOutside;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final bool? enabled;
  final TextEditingController? controller;
  final bool isAutofocus;
  final bool isNoBorder;
  final BorderRadius? borderRadius;
  final Color? focusedBorderColor;
  final Color? unFocusedBorderColor;
  final EdgeInsetsGeometry? contentPadding;
  const AppPasswordTextField({
    super.key,
    this.isAutofocus = false,
    this.isMultibleLines = false,
    this.hintText,
    this.isDense,
    this.textAlign,
    this.onTap,
    this.onEditingComplete,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.onTapOutside,
    this.keyboardType,
    this.enabled,
    this.controller,
    required this.validator,
    this.isNoBorder = false,
    this.borderRadius,
    this.focusedBorderColor,
    this.maxLines = 1,
    this.unFocusedBorderColor,
    this.hintStyle,
    this.textStyle,
    this.contentPadding,
    this.prefixIcon,
    this.autovalidateMode,
  });

  @override
  State<AppPasswordTextField> createState() => _AppPasswordTextFieldState();
}

class _AppPasswordTextFieldState extends State<AppPasswordTextField> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      autovalidateMode: widget.autovalidateMode,
      obscureText: !isShow,
      suffixIcon: isShow
          ? GestureDetector(
              onTap: () {
                setState(() {
                  isShow = !isShow;
                });
              },
              child: Icon(
                Icons.visibility,
                size: 18.sp,
              ),
            )
          : GestureDetector(
              onTap: () {
                setState(() {
                  isShow = !isShow;
                });
              },
              child: Icon(
                Icons.visibility_off,
                size: 18.sp,
              ),
            ),
      hintText: widget.hintText,
      isNoBorder: widget.isNoBorder,
      borderRadius: widget.borderRadius,
      contentPadding: widget.contentPadding,
      controller: widget.controller,
      enabled: widget.enabled,
      focusedBorderColor: widget.focusedBorderColor,
      hintStyle: widget.hintStyle,
      isAutofocus: widget.isAutofocus,
      isDense: widget.isDense,
      isMultibleLines: widget.isMultibleLines,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      prefixIcon: widget.prefixIcon,
      textAlign: widget.textAlign,
      textStyle: widget.textStyle,
      unFocusedBorderColor: widget.unFocusedBorderColor,
      validator: widget.validator,
    );
  }
}
