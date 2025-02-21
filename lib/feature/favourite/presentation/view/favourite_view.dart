import 'package:evently/core/provider/event_list_provider.dart';
import 'package:evently/core/provider/user_provider.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:evently/feature/home/presentation/widget/event_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    if (eventListProvider.favoriteEventList.isEmpty) {
      eventListProvider.getFavoriteEvent(userProvider.currentUser! .id);
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              hintText: AppLocalizations.of(context)!.search_event,
              hintStyle: AppStyle.bold14Primary,
              style: AppStyle.meduim16primary,
              prefixIcon: Image.asset(
                AppAssets.iconSearch,
                width: 24,
                height: 24,
              ),
              bordercolor: AppColors.primaryLight,
            ),
            Expanded(
              child: eventListProvider.favoriteEventList.isEmpty
                  ? Center(
                      child: Text(AppLocalizations.of(context)!
                          .no_event_favorite_found),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return EventItemWidget(
                          eventModel:
                              eventListProvider.favoriteEventList[index],
                        );
                      },
                      itemCount: eventListProvider.favoriteEventList.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
