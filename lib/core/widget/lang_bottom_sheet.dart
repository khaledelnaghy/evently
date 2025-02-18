import 'package:evently/core/provider/app_lang_provider.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LangBottomSheet extends StatefulWidget {
  const LangBottomSheet({super.key});

  @override
  State<LangBottomSheet> createState() => _LangBottomSheetState();
}

class _LangBottomSheetState extends State<LangBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //create object on provider
    var langProvider = Provider.of<AppLangProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              //change language to english
              langProvider.changeLang("en");
            },
            child: langProvider.appLang == "en"
                ? getSelectedItemWidget(AppLocalizations.of(context)!.english)
                : getUnSelectedItemWidget(
                    AppLocalizations.of(context)!.english),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              //change language to arabic
              langProvider.changeLang("ar");
            },
            child: langProvider.appLang == "ar"
                ? getSelectedItemWidget(AppLocalizations.of(context)!.arabic)
                : getUnSelectedItemWidget(AppLocalizations.of(context)!.arabic),
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
