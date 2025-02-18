import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class TabEventWidget extends StatelessWidget {
  const TabEventWidget(
      {super.key, required this.isSelected, required this.eventName});

  final bool isSelected;
  final String eventName;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var weight = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: weight *0.05 , vertical: height * 0.003),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.whiteColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(46),
          color:
              isSelected ? AppColors.whiteColor : AppColors.transparentColor),
      child: Text(eventName,
          style:
              isSelected ? AppStyle.meduim16primary : AppStyle.meduim16white),
    );
  }
}
