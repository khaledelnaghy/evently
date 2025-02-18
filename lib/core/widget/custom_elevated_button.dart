import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      this.textStyle,
      this.backGroundColor,
      this.onButtonClick,
      this.prefixIconButtton,
      this.text});
  final Color? backGroundColor;
  final Widget? prefixIconButtton;
  final String? text;
  final TextStyle? textStyle;
  final void Function()? onButtonClick;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        backgroundColor: backGroundColor ?? AppColors.primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(
          color: AppColors.primaryLight,
          width: 2,
        ),
      ),
        onPressed: onButtonClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixIconButtton ?? const SizedBox(),
          SizedBox(
            width: width * 0.02,
          ),
          Text(
            text ?? "Logout",
            // AppLocalizations.of(context)!.logout,
            style: textStyle ?? AppStyle.meduim20white,
          ),
        ],
      ),
    );
  }
}
