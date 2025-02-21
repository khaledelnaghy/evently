import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/feature/add_event/data/model/event_model.dart';
import 'package:evently/feature/add_event/data/model/my_user.dart';

class FirebaseServices {
//firebase => read json (map) + developer => object
  //add evevnt in database
  //Evevnts => name collection
  //.withConverter => بتعرف الفايربيز نوع الحاجة اللي انا بخزنها سواء كانت Int , String , bool
//<نوع الحاجة اللي بخزنها ف هروخ اعمل class model للحاجة دي >
//fromFirestore => هاخد حاجة من الداتا بيز
//toFirestore => هيعت حاحة في الداتا بيز

  static CollectionReference<EventModel> getEventCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(EventModel.collectionName)
        .withConverter<EventModel>(
          fromFirestore: (snapshot, option) =>
              EventModel.fromFireStore(snapshot.data()),
          toFirestore: (event, _) => event.toFireStore(),
        );
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) => MyUser.fromFireStore(
            snapshot.data(),
          ),
          toFirestore: (myUser, _) => myUser.toFireStore(),
        );
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    var querySnapshot = await getUsersCollection().doc(id).get();
    return querySnapshot.data();
  }

// (هتاخد مني الحاجات اللي عاوز اضبفها اللي هو class model)
  static Future<void> addEventToFireStore(EventModel event , String uId) {
    var collection = getEventCollection(uId); // collection
    var docRef = collection.doc(); // document
    event.id = docRef.id; // auto Id
    // getEventCollection().doc(docRef.id).set(event);
    // event.id = getEventCollection().doc().id;
    return docRef.set(event);
  }
}
