import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:evently/feature/home/presentation/widget/event_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: ListView.builder(
              itemBuilder: (context, index) {
                return EventItemWidget();
              },
              itemCount: 15,
            ),
          ),
          ],
        ),
      ),
    );
  }
}
