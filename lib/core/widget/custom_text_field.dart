import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.bordercolor,
      this.style,
      this.obsecureText = false,
      this.labelStyle,
      this.hintText,
      this.labelText,
      this.hintStyle,
      this.prefixIcon,
      this.suffixIcon});
  final Color? bordercolor;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obsecureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText,
      // obscuringCharacter: "#",
      cursorColor: AppColors.blackColor,
      style: style ?? AppStyle.meduim16Black,
      decoration: InputDecoration(
        hintText: hintText,
        
        labelStyle: labelStyle,
        hintStyle: hintStyle ?? AppStyle.meduim16Grey,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: bordercolor ?? AppColors.greyColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: bordercolor ?? AppColors.greyColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.redColor,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.redColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
