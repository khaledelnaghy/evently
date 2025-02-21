 import 'package:evently/core/provider/app_lang_provider.dart';
import 'package:evently/core/provider/app_theme_provider.dart';
import 'package:evently/core/provider/event_list_provider.dart';
import 'package:evently/core/provider/user_provider.dart';
import 'package:evently/core/theme/app_theme.dart';
import 'package:evently/feature/auth/presentation/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork(); // offline
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppLangProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EventListProvider(),
        ),
           ChangeNotifierProvider(
          create: (context) => UserProvider(),
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
      home: LoginView(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(langProvider.appLang),
    );
  }
}
