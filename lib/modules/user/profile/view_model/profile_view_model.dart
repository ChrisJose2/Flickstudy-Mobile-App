import 'package:flutter/material.dart';
import 'package:flutter_architecture/modules/authentication/user_model.dart';
import 'package:flutter_architecture/modules/user/profile/view_model/profile_repo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel._privateConstructor();

  static final ProfileViewModel _instance =
      ProfileViewModel._privateConstructor();

  factory ProfileViewModel() {
    return _instance;
  }

  Future<bool> updateUserName(String name) async {
    try {
      await ProfileRepo.updateUserName(name);
      await Future.delayed(Duration(seconds: 1));
      User().name = name;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', User().name);
      notifyListeners();
      return true;
    } catch (e) {
      notifyListeners();
      String error = e.toString();
      if (error.startsWith("Exception: ")) {
        error = error.substring(11, error.length);
        if (error.startsWith("Exception: ")) {
          error = error.substring(11, error.length);
        }
      }
      Fluttertoast.showToast(msg: error);
      return false;
    }
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
