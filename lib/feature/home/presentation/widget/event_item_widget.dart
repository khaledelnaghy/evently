import 'package:evently/core/provider/event_list_provider.dart';
import 'package:evently/core/provider/user_provider.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/feature/add_event/data/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({super.key, required this.eventModel});
  final EventModel eventModel;
  @override
  Widget build(BuildContext context) {
     var userProvider = Provider.of<UserProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var widht = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    return Container(
      height: height * 0.31,
      //  horizontal: widht * 0.03,
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryLight,
          width: 2,
        ),
        image: DecorationImage(
          image: AssetImage(eventModel.image),
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
                  "${eventModel.dataTime.day}",
                  style: AppStyle.bold20Primary,
                ),
                Text(
                  DateFormat("MMM").format(eventModel.dataTime),
                  // eventModel.dataTime.month.toString(),
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
                  eventModel.title,
                  style: AppStyle.bold14black,
                ),
                InkWell(
                  onTap: () {
                    //update Favorite
                    eventListProvider.updateIsFavoriteEvent(eventModel , userProvider.currentUser!.id);
                  },
                  child: Image.asset(
                     height:height*0.04,
                    eventModel.isFavorite == true
                        ? AppAssets.iconFavouriteSelected
                        : AppAssets.iconFavourite,
                    color: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
