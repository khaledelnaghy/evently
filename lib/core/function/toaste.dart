
import 'package:evently/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  static Future<bool?> toastMsg(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryLight,
      textColor: AppColors.whiteColor,
      fontSize: 20,
    );
  }
}

class DialogUtils {
  static void showLoading(
      {required String msg, required BuildContext context}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(msg),
                ),
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String title = "",
    String? posActionName,
    Function? posAction,
    String ? negActionName,
    Function? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName),
        ),
      );
    }
    if (negActionName!= null){
      actions.add(TextButton(onPressed: (){
           Navigator.pop(context);
           negAction?.call();
      }, child: Text(negActionName),),);
    }
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text(message),
        title: Text(title , style: Theme.of(context).textTheme.titleMedium,),
        actions: actions,
      );
    });
  }
}
