 import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/feature/add_event/data/model/event_model.dart';
import 'package:flutter/material.dart';
 
class MapEventItem extends StatelessWidget {
  const MapEventItem({super.key, this.eventModel});
  final EventModel? eventModel;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // var eventListProvider = Provider.of<EventListProvider>(context);
    return Container(
      // height: height * 0.8,
      padding: EdgeInsets.symmetric(
          horizontal: width * .02, vertical: height * 0.02),
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.02,
      ).copyWith(
        right: width * .16,
        bottom: height * 0.05,
      ),
      constraints: BoxConstraints(
        maxWidth: width * 0.9,
      ),  
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryLight,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 8,
        children: [
          ClipRRect(
            child: Image.asset(
              eventModel?.image ?? AppAssets.selectedHomeIcon,
              width: width * 0.4,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventModel?.title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.bold20Primary.copyWith(fontSize: 14),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Expanded(
                      child: Text(
                        eventModel?.adress ?? "",
                        maxLines: 3,
                        // softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.bold20Primary.copyWith(
                            fontSize: 12, color: AppColors.blackColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
