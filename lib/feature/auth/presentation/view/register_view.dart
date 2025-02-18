import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:evently/core/widget/navigation_bar_view.dart';
import 'package:evently/feature/auth/presentation/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppAssets.logoApp,
                height: height * 0.25,
              ),
             SizedBox(
                height: height * 0.02,
              ),
            
              CustomTextField(
                hintText: AppLocalizations.of(context)!.name,
                prefixIcon: Icon(Icons.person),
              ),
              SizedBox(
                height: height * 0.02,
              ),
            
              CustomTextField(
                hintText: AppLocalizations.of(context)!.email,
                prefixIcon: Icon(Icons.email),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                obsecureText: true,
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: Icon(Icons.password),
                suffixIcon: Icon(Icons.remove_red_eye),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomTextField(
                obsecureText: true,
                hintText: AppLocalizations.of(context)!.confirm_password,
                prefixIcon: Icon(Icons.password),
                suffixIcon: Icon(Icons.remove_red_eye),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomElevatedButton(
                onButtonClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavigationBarViewHome(),
                    ),
                  );
                },
                text: AppLocalizations.of(context)!.create_account,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                  );
                },
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!
                            .already_have_an_account,
                        style: AppStyle.meduim16Black,
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.login,
                        style: AppStyle.bold16Primary.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
