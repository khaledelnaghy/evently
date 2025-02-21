import 'package:evently/core/firebase/firebase_services.dart';
import 'package:evently/core/function/toaste.dart';
import 'package:evently/core/provider/user_provider.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:evently/core/widget/navigation_bar_view.dart';
import 'package:evently/feature/add_event/data/model/my_user.dart';
import 'package:evently/feature/auth/presentation/view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RegisterView extends StatelessWidget {
  var nameController = TextEditingController(text: "khaled");
  var emailController = TextEditingController(text: "khaled@gmail.com");
  var passwordController = TextEditingController(text: "123456");
  var confirmPasswordController = TextEditingController(text: "123456");
  var formKey = GlobalKey<FormState>();
  RegisterView({super.key});

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
          child: Form(
            key: formKey,
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
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return AppLocalizations.of(context)!.please_enter_name;
                    }
                    return null;
                  },
                  hintText: AppLocalizations.of(context)!.name,
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(
                  height: height * 0.02,
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
                    if (text != passwordController.text) {
                      return AppLocalizations.of(context)!
                          .please_enter_confirm_password;
                    }
                    return null;
                  },
                  controller: confirmPasswordController,
                  obsecureText: true,
                  keyboardType: TextInputType.number,
                  hintText: AppLocalizations.of(context)!.confirm_password,
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: Icon(Icons.remove_red_eye),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomElevatedButton(
                  onButtonClick: () {
                    register(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => NavigationBarViewHome(),
                    //   ),
                    // );
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
      ),
    );
  }

  void register(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(msg: "Loading....", context: context);
      //register
      //show loading
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // add user to firestore
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? "",
            name: nameController.text,
            email: emailController.text);
        await FirebaseServices.addUserToFireStore(myUser);
        //save user in provider 
        var userProvier = Provider.of<UserProvider>(context, listen: false);
        userProvier.updateUser(myUser);
        // hide loading
        DialogUtils.hideLoading(context);
        // show message
        DialogUtils.showMessage(
            message: "Register Successfully",
            context: context,
            title: "Success",
            posActionName: "OK",
            posAction: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigationBarViewHome(),
                ),
              );
            });

        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // hide loading
          DialogUtils.hideLoading(context);
          // show message
          DialogUtils.showMessage(
            message: "The password provided is too weak.",
            context: context,
            title: "Error",
            posActionName: "OK",
          );
        } else if (e.code == 'email-already-in-use') {
          // hide loading
          DialogUtils.hideLoading(context);
          // show message
          DialogUtils.showMessage(
            message: "The account already exists for that email.",
            context: context,
            title: "Error",
            posActionName: "OK",
          );
        } else if (e.code == "network-request-failed") {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              title: "Error",
              posActionName: "OK",
              message: "Enternet Connection is not available.");
        }
      } catch (e) {
        // hide loading
        DialogUtils.hideLoading(context);
        // show message
        DialogUtils.showMessage(
          message: e.toString(),
          context: context,
          title: "Error",
          posActionName: "OK",
        );
      }
    }
  }
}
