class EventModel {
  static const String collectionName = "Events";
  String id;
  String title;
  String description;
  String image;
  String eventName;
  DateTime dataTime;
  String time;
  bool isFavorite;
  double? lang;
  double? lat;
  String? adress;
  EventModel({
    this.id = "",
    required this.title,
    required this.description,
    required this.image,
    required this.eventName,
    required this.dataTime,
    this.adress,
    this.lang,
    this.lat,
    required this.time,
    this.isFavorite = false,
  });
  // json => confirm to object // namedConstructor

  EventModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data!["id"] as String,
          time: data["time"],
          title: data["title"] as String,
          image: data["image"] as String,
          eventName: data["eventName"],
          dataTime: DateTime.fromMillisecondsSinceEpoch(
            data["dataTime"],
          ),
          description: data["description"] as String,
          isFavorite: data["isFavorite"] as bool,
          lang: data["lang"] as double,
          lat: data["lat"] as double,
          adress: data["adress"] as String,
        );

  // object =>confirm to json
  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "image": image,
      "eventName": eventName,
      "dataTime": dataTime.millisecondsSinceEpoch,
      "time": time,
      "isFavorite": isFavorite,
      "lang": lang,
      "lat": lat,
      "adress": adress,
    };
  }
}
