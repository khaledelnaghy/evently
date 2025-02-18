import 'package:evently/core/provider/app_lang_provider.dart';
import 'package:evently/core/provider/app_theme_provider.dart';
import 'package:evently/core/theme/app_theme.dart';
import 'package:evently/core/widget/navigation_bar_view.dart';
import 'package:evently/feature/auth/presentation/view/login_view.dart';
import 'package:evently/feature/setting/presentation/view/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppLangProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppThemeProvider(),
        ),
      ],
      child: const Evently(),
    ),
  );
}

class Evently extends StatelessWidget {
  const Evently({super.key});

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<AppLangProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:themeProvider.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(langProvider.appLang),
    );
  }
}
