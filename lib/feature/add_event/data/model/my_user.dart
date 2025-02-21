class MyUser {
  static const String collectionName = "Users";

  String id;
  String name;
  String email;

  MyUser({required this.id, required this.name, required this.email});
  //json to object
  MyUser.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data!["id"],
          name: data["name"],
          email: data["email"],
        );
//object to json
  Map<String, dynamic> toFireStore() {
    return {"id": id, "name": name, "email": email};
  }
}
