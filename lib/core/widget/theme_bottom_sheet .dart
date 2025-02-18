 import 'package:evently/core/provider/app_theme_provider.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //create object on provider
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              //change theme to dark
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: themeProvider.isDarkMode()
                ? getSelectedItemWidget(AppLocalizations.of(context)!.dark)
                : getUnSelectedItemWidget(
                    AppLocalizations.of(context)!.dark),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              //change theme to light
              themeProvider.changeTheme(ThemeMode.light);
            },
            child:themeProvider.isDarkMode()
                ? getUnSelectedItemWidget(AppLocalizations.of(context)!.light)
                : getSelectedItemWidget (AppLocalizations.of(context)!.light),
          )
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          //  AppLocalizations.of(context)!.english,
          text,
          style: AppStyle.bold20Primary,
        ),
        Icon(
          Icons.check,
          color: AppColors.primaryLight,
          size: 25,
        ),
      ],
    );
  }

  Widget getUnSelectedItemWidget(String text) {
    return Text(
      //  AppLocalizations.of(context)!.english,
      text,
      style: AppStyle.bold20Primary,
    );
  }
}
