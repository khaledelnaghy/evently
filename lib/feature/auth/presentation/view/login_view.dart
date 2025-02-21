import 'package:evently/core/firebase/firebase_services.dart';
import 'package:evently/core/function/toaste.dart';
import 'package:evently/core/provider/user_provider.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:evently/core/widget/navigation_bar_view.dart';
import 'package:evently/feature/auth/presentation/view/forget_password_view.dart';
import 'package:evently/feature/auth/presentation/view/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var emailController = TextEditingController(text: "khaled@gmail.com");

  var passwordController = TextEditingController(text: "123456");

  var formKey = GlobalKey<FormState>();

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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.05),
                Image.asset(
                  AppAssets.logoApp,
                  height: height * 0.30,
                ),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!.please_enter_email;
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if (!emailValid) {
                      return AppLocalizations.of(context)!
                          .please_enter_email_valid;
                    }
                    return null;
                  },
                  controller: emailController,
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: Icon(Icons.email),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!
                          .please_enter_password;
                    }
                    if (text.length < 6) {
                      return AppLocalizations.of(context)!
                          .password_should_be_at_least;
                    }
                    return null;
                  },
                  controller: passwordController,
                  obsecureText: true,
                  keyboardType: TextInputType.phone,
                  hintText: AppLocalizations.of(context)!.password,
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: Icon(Icons.remove_red_eye),
                ),
                SizedBox(
                  height: height * 0.02,
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
                    login();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => NavigationBarViewHome(),
                    //   ),
                    // );
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
                          text: AppLocalizations.of(context)!
                              .dont_have_an_account,
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
                  text: AppLocalizations.of(context)!.login_with_google,
                  backGroundColor: AppColors.whiteColor,
                  prefixIconButtton: Image.asset(
                    AppAssets.iconGoogle,
                    height: height * 0.03,
                  ),
                  textStyle: AppStyle.meduim20Primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      // login
      DialogUtils.showLoading(msg: "Waiting....", context: context);
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseServices.readUserFromFireStore(
            credential.user?.uid ?? "");
        if (user == null) {
          return;
        }
        // save user in Provider
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        print(credential.user?.uid ?? "");
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context,
            message: "Login Successfully",
            title: "Success",
            posActionName: "OK",
            posAction: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationBarViewHome(),
                  ),);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: "No user found for that email.",
            title: "Error",
            posActionName: "OK",
          );
        } else if (e.code == 'wrong-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: "Wrong password provided for that user.",
            title: "Error",
            posActionName: "OK",
          );
        } else if (e.code == "invalid-credential") {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              title: "Error",
              posActionName: "OK",
              message:
                  "The supplied auth credential is incorrect,, malformed or has expired.");
        } else if (e.code == "network-request-failed") {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              title: "Error",
              posActionName: "OK",
              message: "Enternet Connection is not available.");
          print("can not connection");
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: "Error",
          posActionName: "OK",
        );
      }
    }
  }
}
