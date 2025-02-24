import 'package:evently/core/function/toaste.dart';
import 'package:evently/core/provider/event_list_provider.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/navigation_bar_view.dart';
import 'package:evently/feature/add_event/data/model/event_model.dart';
import 'package:evently/feature/event_details/widget/edit_event_view.dart';
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsView extends StatefulWidget {
  const EventDetailsView({super.key, required this.eventModel});
  final EventModel eventModel;

  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var formatedDate = DateFormat("dd MMM yyyy");
    var evenListProvider = Provider.of<EventListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: AppStyle.meduim16primary,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditEventView(eventModel: widget.eventModel),
                      ),
                    );
                  },
                  child: Image.asset(
                    AppAssets.iconEdit,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    String? uid = FirebaseAuth.instance.currentUser?.uid ?? "";

                    DialogUtils.showMessage(
                      context: context,
                      title: "Delete Event",
                      message: "Are you sure you want to delete this event?",
                      posActionName: "Ok",
                      negActionName: "Cancel",
                      posAction: () {
                        evenListProvider.deleteEvent(
                            eventModelId: widget.eventModel.id, uid: uid);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationBarViewHome(
                                eventModel:
                                    widget.eventModel), // تمرير eventModel
                          ),
                        );
                      },
                    );
                  },
                  child: Image.asset(
                    AppAssets.iconDelete,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                widget.eventModel.image,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                AppLocalizations.of(context)!.we_are_going_to_play_football,
                style: AppStyle.bold20Primary,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 2,
                    color: AppColors.primaryLight,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryLight,
                      ),
                      child: Image.asset(
                        AppAssets.iconClender,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatedDate.format(widget.eventModel.dataTime),
                          style: AppStyle.meduim16primary,
                        ),
                        Text(
                          widget.eventModel.time.toString().trim(),
                          style: AppStyle.meduim16primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 2,
                    color: AppColors.primaryLight,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.01,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryLight,
                      ),
                      child: Image.asset(
                        AppAssets.iconLocation,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      AppLocalizations.of(context)!.choose_event_location,
                      style: AppStyle.meduim16primary,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColors.primaryLight,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                AppLocalizations.of(context)!.description,
                style: AppStyle.meduim16Black,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                widget.eventModel.description,
                style: AppStyle.meduim16Black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
