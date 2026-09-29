import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/utilities/utils.dart';
import 'package:flutter_architecture/modules/authentication/user_model.dart';
import 'package:flutter_architecture/modules/user/model/courses_model.dart';
import 'package:flutter_architecture/modules/user/model/package_model.dart';
import 'package:flutter_architecture/modules/user/model/student_subscription.dart';
import 'package:flutter_architecture/modules/user/user_repo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends ChangeNotifier {
  UserViewModel._privateConstructor();

  static final UserViewModel _instance = UserViewModel._privateConstructor();

  factory UserViewModel() {
    return _instance;
  }

  bool _isLoggedIn = false;

  bool loginLoadingStatus = false;

  Future<void> loginWithPassword(
      {required String email, required String password}) async {
    try {
      loginLoadingStatus = true;
      notifyListeners();
      await UserRepo.loginWithPassword(email: email, password: password);
      await Utilities.saveUserToSharedPreferences();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("is_logged_in", true);
      _isLoggedIn = true;
      loginLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      _isLoggedIn = false;
      loginLoadingStatus = false;
      notifyListeners();
      String error = e.toString();
      if (error.startsWith("Exception: ")) {
        error = error.substring(11, error.length);
        if (error.startsWith("Exception: ")) {
          error = error.substring(11, error.length);
        }
      }
      Fluttertoast.showToast(msg: error);
    }
  }

  String? otp;

  Future<bool> loginWithOTP(
      {required BuildContext context, required String phone}) async {
    try {
      loginLoadingStatus = true;
      notifyListeners();
      otp = await UserRepo.loginWithOTP(phone: phone);
      loginLoadingStatus = false;
      notifyListeners();
      return true;
    } catch (e) {
      loginLoadingStatus = false;
      notifyListeners();
      String error = e.toString();
      if (error.startsWith("Exception: ")) {
        error = error.substring(11, error.length);
        if (error.startsWith("Exception: ")) {
          error = error.substring(11, error.length);
        }
      }
      Fluttertoast.showToast(msg: error);
      if (error.toLowerCase().contains("no mobile")) {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.pushReplacementNamed(context, AppRoutes.register);
      }
      return false;
    }
  }

  Future<void> verifyOTP({required String phone, required String otp}) async {
    try {
      loginLoadingStatus = true;
      notifyListeners();
      await UserRepo.verifyOTP(phone: phone, otp: otp);
      await Utilities.saveUserToSharedPreferences();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("is_logged_in", true);
      _isLoggedIn = true;
      loginLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      _isLoggedIn = false;
      loginLoadingStatus = false;
      notifyListeners();
      String error = e.toString();
      if (error.startsWith("Exception: ")) {
        error = error.substring(11, error.length);
        if (error.startsWith("Exception: ")) {
          error = error.substring(11, error.length);
        }
      }
      Fluttertoast.showToast(msg: error);
    }
  }

  Future<void> registerUser(
      {required String name,
      required String email,
      required String phone}) async {
    try {
      loginLoadingStatus = true;
      notifyListeners();
      String? result =
          await UserRepo.registerUser(phone: phone, email: email, name: name);
      if (result != null) {
        User().sid = result;
        await UserRepo.userProfileDetails(sid: result);
        await Utilities.saveUserToSharedPreferences();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("is_logged_in", true);
        _isLoggedIn = true;
        loginLoadingStatus = false;
        notifyListeners();
      } else {
        throw Exception("Failed to register user");
      }
    } catch (e) {
      _isLoggedIn = false;
      loginLoadingStatus = false;
      notifyListeners();
      String error = e.toString();
      if (error.startsWith("Exception: ")) {
        error = error.substring(11, error.length);
        if (error.startsWith("Exception: ")) {
          error = error.substring(11, error.length);
        }
      }
      Fluttertoast.showToast(msg: error);
    }
  }

  bool checkSubscriptionLoadingStatus = false;
  SubscriptionModel? studentSubscription;

  Future<void> checkStudentSubscription() async {
    try {
      checkSubscriptionLoadingStatus = true;
      notifyListeners();
      studentSubscription = await UserRepo.checkStudentSubscription();
      checkSubscriptionLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      checkSubscriptionLoadingStatus = false;
      notifyListeners();
    }
  }

  bool createSubscriptionLoadingStatus = false;
  bool isCreatedSubscription = false;

  Future<void> createSubscription({
    required int courseID,
    required String price,
    required String courseName,
    required String transactionId,
  }) async {
    try {
      createSubscriptionLoadingStatus = true;
      notifyListeners();
      bool? result = await UserRepo.createSubscription(
        courseID: courseID,
        price: price,
        courseName: courseName,
        transactionId: transactionId,
      );
      if (result == true) {
        isCreatedSubscription = true;
      } else {
        isCreatedSubscription = false;
      }
      createSubscriptionLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      isCreatedSubscription = false;

      createSubscriptionLoadingStatus = false;
      notifyListeners();
    }
  }

  PackageModel? packageModel;
  CoursesListModel? coursesModel;
  bool packageLoadingStatus = false;

  Future<void> getPackageList() async {
    try {
      packageLoadingStatus = true;
      notifyListeners();
      packageModel = await UserRepo.getPackageList();
      coursesModel = await UserRepo.getPackageCoursesList(packageModel!.id);

      packageLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      packageLoadingStatus = false;
      notifyListeners();
    }
  }

  bool get isLoggedIn => _isLoggedIn;
}
