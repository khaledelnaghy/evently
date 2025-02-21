import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseDataOrTime extends StatelessWidget {
  const ChooseDataOrTime(
      {super.key,
      required this.chooseDataOrTime,
      required this.iconName,
      required this.eventDataOrTime,
      required this.onChooseDataOrTimeClicked});

  final String eventDataOrTime;
  final String chooseDataOrTime;
  final Function onChooseDataOrTimeClicked;
  final String iconName;
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Image.asset(
          iconName,
          //  AppAssets.iconEventData,
        ),
        SizedBox(
          width: width * 0.04,
        ),
        Text(
          eventDataOrTime,
          // AppLocalizations.of(context)!.event_data,
          style: AppStyle.meduim16Black,
        ),
        // SizedBox(
        //   width: width * 0.21,
        // ),
        Spacer(),
        TextButton(
          onPressed: () {
            onChooseDataOrTimeClicked();
          },
          child: Text(
            chooseDataOrTime,
            style: AppStyle.meduim16primary,
          ),
        ),
      ],
    );
  }
}
