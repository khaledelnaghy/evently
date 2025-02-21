import 'package:evently/core/provider/app_lang_provider.dart';
import 'package:evently/core/provider/app_theme_provider.dart';
import 'package:evently/core/provider/event_list_provider.dart';
import 'package:evently/core/provider/user_provider.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/elevated_button_logout.dart';
import 'package:evently/core/widget/lang_bottom_sheet.dart';
import 'package:evently/core/widget/theme_bottom_sheet%20.dart';
import 'package:evently/feature/auth/presentation/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var langProvider = Provider.of<AppLangProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: height * 0.04,
              left: width * 0.04,
              right: width * 0.02,
            ),
            height: height * 0.25,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  AppAssets.routeImage,
                  height: height * 0.15,
                ),
                SizedBox(
                  width: width * 0.04,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userProvider.currentUser!.name,
                        style: AppStyle.bold24white,
                      ),
                      Text(
                         userProvider.currentUser!.email,
                        style: AppStyle.meduim16white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: AppStyle.bold20black,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                  onTap: () {
                    showLanguageBottomSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.primaryLight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          langProvider.appLang == "en"
                              ? AppLocalizations.of(context)!.english
                              : AppLocalizations.of(context)!.arabic,
                          style: AppStyle.bold20Primary,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.primaryLight,
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: AppStyle.bold20black,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                  onTap: () {
                    showThemeBottomSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: AppColors.primaryLight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          themeProvider.isDarkMode()
                              ? AppLocalizations.of(context)!.dark
                              : AppLocalizations.of(context)!.light,
                          style: AppStyle.bold20Primary,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.primaryLight,
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.04,
            ),
            child: ElevatedButtonLogout(
              onPressed: () {
                //eventList is Empty
                eventListProvider.favoriteEventList = [];
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginView(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LangBottomSheet(),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}
