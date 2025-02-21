import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class ListViewBuilderTabs extends StatelessWidget {
  const ListViewBuilderTabs(
      {super.key, required this.eventName, required this.isSelected});
  final bool isSelected;
  final String eventName;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var weight = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: weight * 0.05, vertical: height * 0.006),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryLight,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(46),
          color:
              isSelected ? AppColors.primaryLight : AppColors.transparentColor),
      child: Text(eventName,
          style:
              isSelected ? AppStyle.meduim16white : AppStyle.meduim16primary),
    );
  }
}
