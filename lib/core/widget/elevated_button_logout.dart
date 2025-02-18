import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ElevatedButtonLogout extends StatelessWidget {
  const ElevatedButtonLogout({super.key, this.onPressed});

  final void Function()? onPressed;
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
        backgroundColor: AppColors.redColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            Icons.logout,
            color: AppColors.whiteColor,
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Text(
            AppLocalizations.of(context)!.logout,
            style: AppStyle.regular20white,
          ),
        ],
      ),
    );
  }
}
