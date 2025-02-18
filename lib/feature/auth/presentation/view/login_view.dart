import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:evently/core/widget/navigation_bar_view.dart';
import 'package:evently/feature/auth/presentation/view/forget_password_view.dart';
import 'package:evently/feature/auth/presentation/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: height * 0.05),
              Image.asset(
                AppAssets.logoApp,
                height: height * 0.30,
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
              InkWell(
                   onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgetPasswordView(),
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.forget_password,
                  style: AppStyle.bold16Primary.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryLight,
                  ),
                  textAlign: TextAlign.end,
                ),
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
                text: AppLocalizations.of(context)!.login,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterView(),
                    ),
                  );
                },
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.dont_have_an_account,
                        style: AppStyle.meduim16Black,
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.create_account,
                        style: AppStyle.bold16Primary.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: AppColors.primaryLight,
                      endIndent: 10,
                      indent: 10,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.or,
                    style: AppStyle.meduim16primary,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      indent: 10,
                        endIndent: 10,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ],
              ),
               SizedBox(
                height: height * 0.02,
              ),
              CustomElevatedButton(
                onButtonClick: () {},
                text:  AppLocalizations.of(context)!.login_with_google,
                backGroundColor: AppColors.whiteColor,
                prefixIconButtton: Image.asset(AppAssets.iconGoogle , height: height * 0.03,),
                textStyle: AppStyle.meduim20Primary,
              ),
            ],
          ),
        ),
      ),
    
    );
  }
}
