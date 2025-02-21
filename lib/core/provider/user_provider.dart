import 'package:evently/feature/add_event/data/model/my_user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  MyUser ? currentUser ; 

//save user
  void updateUser (MyUser newUser){ 
    currentUser = newUser;
    notifyListeners();
  }
}