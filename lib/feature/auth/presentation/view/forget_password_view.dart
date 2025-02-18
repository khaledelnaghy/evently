import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.forget_password),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.02,
        ),
        child: Column(
          children: [
            Image.asset(
              AppAssets.changeSetting,
            ),
            SizedBox(height: height * 0.02),
            CustomElevatedButton(
              onButtonClick: () {},
              text: AppLocalizations.of(context)!.reset_password,
            ),
          ],
        ),
      ),
    );
  }
}
