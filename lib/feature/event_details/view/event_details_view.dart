import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/feature/add_event/data/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key, required this.eventModel});
  final EventModel eventModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: AppStyle.meduim16primary,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                  color: AppColors.primaryLight,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete,
                  size: 20,
                  color: AppColors.redColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
