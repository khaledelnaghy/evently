import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/feature/home/presentation/widget/event_item_widget.dart';
import 'package:evently/feature/home/presentation/widget/tab_event_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<String> eventName = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sports,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.metting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workShop,
      AppLocalizations.of(context)!.bookClup,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
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
                  "Route",
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
                  length: eventName.length,
                  child: TabBar(
                    isScrollable: true,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    tabAlignment: TabAlignment.start,
                    indicatorColor: AppColors.transparentColor,
                    dividerColor: AppColors.transparentColor,
                    labelPadding:
                        EdgeInsets.symmetric(horizontal: width * 0.01),
                    tabs: eventName.asMap().entries.map((entry) {
                      int index = entry.key;
                      String name = entry.value;
                      return TabEventWidget(
                          isSelected: selectedIndex == index, eventName: name);
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
             padding:   EdgeInsets.symmetric(horizontal: width *0.02),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return EventItemWidget();
                },
                itemCount: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
