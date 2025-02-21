import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/feature/add_event/view/add_event_view.dart';
import 'package:evently/feature/favourite/presentation/view/favourite_view.dart';
import 'package:evently/feature/home/presentation/view/home_view.dart';
import 'package:evently/feature/map/presentation/view/map_view.dart';
import 'package:evently/feature/setting/presentation/view/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationBarViewHome extends StatefulWidget {
  const NavigationBarViewHome({super.key});

  @override
  State<NavigationBarViewHome> createState() => _NavigationBarViewHomeState();
}

class _NavigationBarViewHomeState extends State<NavigationBarViewHome> {
  int selectedItem = 0;
  List<Widget> tabs = [
    HomeView(),
    MapView(),
    FavouriteView(),
    SettingView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.transparentColor,
        ),
        child: BottomAppBar(
          padding: EdgeInsets.zero,
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
          notchMargin: 4,
          child: BottomNavigationBar(
            currentIndex: selectedItem,
            onTap: (index) {
              setState(() {
                selectedItem = index;
              });
            },
            items: [
              buildbottomNavigationBarItem(
                  iconName: AppAssets.homeIcon,
                  index: 0,
                  iconSelectedName: AppAssets.selectedHomeIcon,
                  label: AppLocalizations.of(context)!.home),
              buildbottomNavigationBarItem(
                  iconName: AppAssets.mapIcon,
                  index: 1,
                  iconSelectedName: AppAssets.selectedMapIcon,
                  label: AppLocalizations.of(context)!.map),
              buildbottomNavigationBarItem(
                  iconName: AppAssets.favouriteIcon,
                  index: 2,
                  iconSelectedName: AppAssets.iconFavourite,
                  label: AppLocalizations.of(context)!.favourite),
              buildbottomNavigationBarItem(
                  iconName: AppAssets.profileIcon,
                  index: 3,
                  iconSelectedName: AppAssets.selectedprofileIcon,
                  label: AppLocalizations.of(context)!.profile),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEventView(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: AppColors.whiteColor,
          size: 25,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedItem],
    );
  }

  BottomNavigationBarItem buildbottomNavigationBarItem(
      {required String iconSelectedName,
      required String iconName,
      required String label,
      required int index}) {
    return BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage(selectedItem == index ? iconSelectedName : iconName),
        ),
        label: label);
  }
}
