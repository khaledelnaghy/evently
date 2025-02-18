import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var widht = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.31,
      //  horizontal: widht * 0.03,
      margin: EdgeInsets.symmetric(
         vertical: height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryLight,
          width: 2,
        ),
        image: DecorationImage(
          image: AssetImage(AppAssets.birthdayImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: widht * 0.01),
            margin: EdgeInsets.symmetric(
              horizontal: widht * 0.02,
              vertical: height * 0.005,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  "22",
                  style: AppStyle.bold20Primary,
                ),
                Text(
                  "Dec",
                  style: AppStyle.bold20Primary,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: widht * 0.02, vertical: height * 0.01),
            margin: EdgeInsets.symmetric(
                horizontal: widht * 0.02, vertical: height * 0.01),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "this is a birthday",
                  style: AppStyle.bold14black,
                ),
                Image.asset(
                  AppAssets.favouriteIcon,
                  color: AppColors.primaryLight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
