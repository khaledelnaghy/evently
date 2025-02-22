import 'package:evently/core/provider/event_list_provider.dart';
import 'package:evently/core/provider/user_provider.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/feature/event_details/view/event_details_view.dart';
import 'package:evently/feature/home/presentation/widget/event_item_widget.dart';
import 'package:evently/feature/home/presentation/widget/tab_event_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var evenListProvider = Provider.of<EventListProvider>(context);

    evenListProvider.getEventNameList(context);
    if (userProvider.currentUser != null) {
      evenListProvider.getAllEvents(userProvider.currentUser!.id);
    }

    // if (evenListProvider.eventList.isEmpty) {
    //   evenListProvider.getAllEvents(userProvider.currentUser!.id);
    // }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // List<String> eventName = [
    //   AppLocalizations.of(context)!.all,
    //   AppLocalizations.of(context)!.sports,
    //   AppLocalizations.of(context)!.birthday,
    //   AppLocalizations.of(context)!.metting,
    //   AppLocalizations.of(context)!.gaming,
    //   AppLocalizations.of(context)!.workShop,
    //   AppLocalizations.of(context)!.bookClup,
    //   AppLocalizations.of(context)!.exhibition,
    //   AppLocalizations.of(context)!.holiday,
    //   AppLocalizations.of(context)!.eating,
    // ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.09,
        backgroundColor: AppColors.primaryLight,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welecome_back,
                  style: AppStyle.regular14white,
                ),
                Text(
                  userProvider.currentUser?.name ?? "User",
                  style: AppStyle.bold24white,
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.sunny,
                  color: AppColors.whiteColor,
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Container(
                  margin: EdgeInsets.only(right: width * 0.02),
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.01, vertical: height * 0.01),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "En",
                    style: AppStyle.bold14Primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            height: height * 0.12,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppAssets.mapIcon,
                      height: height * 0.04,
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Text("Cairo", style: AppStyle.meduim14white),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                DefaultTabController(
                  length: evenListProvider.eventsNameList.length,
                  child: TabBar(
                    isScrollable: true,
                    onTap: (index) {
                      evenListProvider.changeSelectedIndex(
                          index, userProvider.currentUser!.id);
                    },
                    tabAlignment: TabAlignment.start,
                    indicatorColor: AppColors.transparentColor,
                    dividerColor: AppColors.transparentColor,
                    labelPadding:
                        EdgeInsets.symmetric(horizontal: width * 0.01),
                    tabs: evenListProvider.eventsNameList
                        .asMap()
                        .entries
                        .map((entry) {
                      int index = entry.key;
                      String name = entry.value;
                      return TabEventWidget(
                          isSelected: evenListProvider.selectedIndex == index,
                          eventName: name);
                    }).toList(),

                    // tabs: eventName.map((eventName) {
                    //   return TabEventWidget(
                    //       isSelected:
                    //           selectedIndex == eventName.indexOf(eventName),
                    //       eventName: eventName);
                    // }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: evenListProvider.filterEventList.isEmpty
                  ? Center(
                      child: Text(AppLocalizations.of(context)!.no_event_found),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventDetailsView(
                                  eventModel:
                                      evenListProvider.filterEventList[index],
                                ),
                              ),
                            );
                          },
                          child: EventItemWidget(
                            eventModel: evenListProvider.filterEventList[index],
                          ),
                        );
                      },
                      itemCount: evenListProvider.filterEventList.length,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
