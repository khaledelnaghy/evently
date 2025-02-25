import 'package:evently/core/provider/event_list_provider.dart';
import 'package:evently/core/provider/user_provider.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/app_colors.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:evently/feature/add_event/data/model/event_model.dart';
import 'package:evently/feature/add_event/widget/choose_data_or_time.dart';
import 'package:evently/feature/add_event/widget/list_view_builder_tabs.dart';
import 'package:evently/feature/home/presentation/view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditEventView extends StatefulWidget {
  const EditEventView({super.key, this.eventModel});

  final EventModel? eventModel;
  @override
  State<EditEventView> createState() => _EditEventViewState();
}

class _EditEventViewState extends State<EditEventView> {
  var formKey = GlobalKey<FormState>();
  // int selectedIndex = 0;
  DateTime? selectedDateTime;
  TimeOfDay? selectedTime;
  String formatedDate = "";

  String formatedTime = "";
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  String selectedImage = "";
  String selectedEvevnt = "";
  late EventListProvider eventListProvider;
  late UserProvider userProvider;

  // String selectedEvent ="Sport";
  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    userProvider = Provider.of(context);
    eventListProvider.getEventNameList(context);
    eventListProvider.eventsNameList.removeAt(0);

    List<String> imageSelectedNamedList = [
      AppAssets.backgroundSport,
      AppAssets.birthdayImage,
      AppAssets.backgroundMetting,
      AppAssets.backgroundGaming,
      AppAssets.backgroundWorkShop,
      AppAssets.backgroundBookClub,
      AppAssets.backgroundExhistion,
      AppAssets.backgroundHoliday,
      AppAssets.backgroundEating,
    ];
    selectedImage = imageSelectedNamedList[eventListProvider.selectedIndex];
    selectedEvevnt =
        eventListProvider.eventsNameList[eventListProvider.selectedIndex];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.primaryLight,
        ),
        title: Text(
          AppLocalizations.of(context)!.edit_event,
          style: AppStyle.meduim20Primary,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  // mapEventList[selectedEvent]??  AppAssets.backgroundSport,
                  height: height * 0.31,
                  selectedImage,
                  // imageSelectedNamedList[selectedIndex],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              SizedBox(
                height: height * 0.05,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: width * 0.02,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        eventListProvider.changeSelectedIndex(
                            index, userProvider.currentUser!.id);
                      },
                      child: ListViewBuilderTabs(
                        isSelected: eventListProvider.selectedIndex == index,
                        eventName: eventListProvider.eventsNameList[index],
                      ),
                    );
                  },
                  itemCount: eventListProvider.eventsNameList.length,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: AppStyle.meduim16Black,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    CustomTextField(
                      controller: titleController,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_event_title;
                        }
                        return null;
                      },
                      hintText: AppLocalizations.of(context)!.event_title,
                      prefixIcon: Icon(
                        Icons.edit_note,
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
                      height: height * 0.01,
                    ),
                    CustomTextField(
                      controller: descriptionController,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(context)!
                              .please_enter_description_title;
                        }
                        return null;
                      },
                      hintText: AppLocalizations.of(context)!.event_description,
                      maxLines: 3,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    ChooseDataOrTime(
                      iconName: AppAssets.iconEventData,
                      chooseDataOrTime: selectedDateTime == null
                          ? AppLocalizations.of(context)!.choose_data
                          : formatedDate,
                      eventDataOrTime: AppLocalizations.of(context)!.event_data,
                      onChooseDataOrTimeClicked: chooseData,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    ChooseDataOrTime(
                      iconName: AppAssets.iconEventData,
                      chooseDataOrTime: selectedTime == null
                          ? AppLocalizations.of(context)!.choose_Time
                          : formatedTime,
                      eventDataOrTime: AppLocalizations.of(context)!.event_time,
                      onChooseDataOrTimeClicked: chooseTime,
                    ),
                    SizedBox(
                      height: height * 0.01,
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
                    CustomElevatedButton(
                      onButtonClick: updateEvent,
                      text: AppLocalizations.of(context)!.update_event,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateEvent() {
  if (formKey.currentState?.validate() == true) {
    String? uid = FirebaseAuth.instance.currentUser?.uid ?? "";

    final existingEvent = widget.eventModel;
    if (existingEvent == null) {
      print("Error: eventModel is null");
      return;
    }

    EventModel eventModel = EventModel(
      id: existingEvent.id,
      title: titleController.text,
      description: descriptionController.text,
      image: selectedImage,
      eventName: selectedEvevnt,
      dataTime: selectedDateTime ?? existingEvent.dataTime,
      time: formatedTime.isNotEmpty ? formatedTime : existingEvent.time,
    );

    eventListProvider.updateEvent(eventModel: eventModel, uid: uid);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeView(eventModel: eventModel),
      ),
    );
  }
}


  void chooseData() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(
          days: 365,
        ),
      ),
    );
    setState(() {
      selectedDateTime = chooseDate;
      formatedDate = selectedDateTime != null
          ? DateFormat("dd/MM/yyyy").format(selectedDateTime!)
          : "لم يتم اختيار تاريخ";
      // selectedDateTime = chooseDate;
      //  formatedDate = DateFormat("dd/MM/yyyy").format(selectedDateTime);
    });
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      selectedTime = chooseTime;
      formatedTime = selectedTime != null
          ? selectedTime!.format(context)
          : "لم يتم اختيار وقت";
    });
  }
}
