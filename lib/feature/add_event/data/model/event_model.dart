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
  EventModel({
    this.id = "",
    required this.title,
    required this.description,
    required this.image,
    required this.eventName,
    required this.dataTime,
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
          dataTime: DateTime.fromMillisecondsSinceEpoch(data["dataTime"],),
          description: data["description"] as String,
          isFavorite: data["isFavorite"] as bool,
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
    };
  }
}
