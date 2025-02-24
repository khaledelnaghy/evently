import 'package:evently/core/firebase/firebase_services.dart';
import 'package:evently/core/function/toaste.dart';
import 'package:evently/feature/add_event/data/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventListProvider extends ChangeNotifier {
  //  data  اللي بتتأثر عندي في اكتر من مكان
  // function

  List<EventModel> eventList = [];
  List<EventModel> filterEventList = []; // filter
  List<String> eventsNameList = [];

  void getEventNameList(BuildContext context) {
    eventsNameList = [
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
  }

  // List<String> eventsNameList = [
  //   "All",
  //   "Sports",
  //   "Birthday",
  //   "Metting",
  //   "Gaming",
  //   "WorkShop",
  //   "Book Clup",
  //   "Exhibition",
  //   "Holiday",
  //   "Eating",
  // ];
  int selectedIndex = 0;
  List<EventModel> favoriteEventList = []; // favorite

  void getAllEvents(String uId) async {
    print("in first");
    var querySnapshot = await FirebaseServices.getEventCollection(uId).get();
    //.map => alternative type of List to type List of EventModel
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    //sorting
    eventList.sort((EventModel a, EventModel b) {
      return a.dataTime.compareTo(b.dataTime);
    });
    filterEventList = eventList;
    notifyListeners();
  }

  void getFilterEvent(String uId) async {
    var querySnapshot = await FirebaseServices.getEventCollection(uId)
        // .where("eventName", isEqualTo: eventsName[selectedIndex])
        .get();
    //.map => alternative type of List to type List of EventModel
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    //filtering events

    filterEventList = eventList.where(
      (event) {
        return event.eventName == eventsNameList[selectedIndex];
      },
    ).toList();
    //todo : sorting
    eventList.sort((EventModel a, EventModel b) {
      return a.dataTime.compareTo(b.dataTime);
    });
    notifyListeners();
  }

  void getFavoriteEvent(String uId) async {
    var querySnapshot = await FirebaseServices.getEventCollection(uId)
        .orderBy("dataTime", descending: false)
        .where("isFavorite", isEqualTo: true)
        .get();
    favoriteEventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void updateIsFavoriteEvent(EventModel event, String uId) {
    FirebaseServices.getEventCollection(uId)
        .doc(event.id)
        .update({"isFavorite": !event.isFavorite}).then((value) {
      ToastMessage.toastMsg("Event Updated Successfully");
    }).timeout(
            Duration(
              milliseconds: 500,
            ),
            onTimeout: () {});
    selectedIndex == 0 ? getAllEvents(uId) : getFilterEvent(uId);
    getFavoriteEvent(uId);
    // notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;
    if (selectedIndex == 0) {
      getAllEvents(uId);
    } else {
      getFilterEvent(uId);
    }
  }

  Future<void> updateEvent(
      {required EventModel eventModel, required String uid}) async {
    var collection = FirebaseServices.getEventCollection(uid);
    await collection
        .doc(eventModel.id)
        .update(
          eventModel.toFireStore(),
        )
        .then((value) {
      selectedIndex == 0 ? getAllEvents(uid) : getFilterEvent(uid);
    });
  }

  Future<void> deleteEvent(
      {required String eventModelId, required String uid}) async {
    var collection = FirebaseServices.getEventCollection(uid);
    await collection.doc(eventModelId).delete().then((value) {
      selectedIndex == 0 ? getAllEvents(uid) : getFilterEvent(uid);
    });
  }
}
