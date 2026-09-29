import 'package:flutter_architecture/common/services/base_service.dart';
import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:flutter_architecture/modules/authentication/user_model.dart';
import 'package:flutter_architecture/modules/user/model/courses_model.dart';
import 'package:flutter_architecture/modules/user/model/package_model.dart';
import 'package:flutter_architecture/modules/user/model/student_subscription.dart';

class UserRepo {
  static Future<User> loginWithPassword(
      {required String email, required String password}) async {
    Map<String, dynamic> payload = {
      'email': email,
      'password': password,
    };

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.LOGIN, payload);
      if (response['replyCode'] == 'success') {
        return User.fromJson(response['data']);
      } else {
        print("Error: ${response['replyMsg']}");
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  static Future<String> loginWithOTP({required String phone}) async {
    Map<String, dynamic> payload = {
      'phone': phone,
      'role_id': "2",
      'need_otp': "0"
    };

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.OTP_GENERATE, payload);
      if (response['replyCode'] == 'success' && response['exist'] == "1") {
        return response['otp'];
      } else {
        print("Error: ${response['replyMsg']}");
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  static Future<User> verifyOTP(
      {required String phone, required String otp}) async {
    Map<String, dynamic> payload = {'phone': phone, 'otp': "123456"};

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.OTP_VERIFY, payload);
      if (response['replyCode'] == 'success') {
        User().sid = response['sid'];
        return User.fromJson(response['data']);
      } else {
        print("Error: ${response['replyMsg']}");
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  static Future<String?> registerUser(
      {required String name,
      required String email,
      required String phone}) async {
    Map<String, dynamic> payload = {
      'name': name,
      'email': email,
      'phone': phone,
    };

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.REGISTER_USER, payload);
      if (response['replyCode'] == 'success') {
        return response['sid'];
      } else {
        print("Error: ${response['replyMsg']}");
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  static Future<User> userProfileDetails({required String sid}) async {
    Map<String, dynamic> payload = {'sid': sid};

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.USER_PROFILE_DETAILS, payload);
      if (response['replyCode'] == 'success') {
        // User().sid = response['sid'];
        return User.fromJson(response['data'][0]);
      } else {
        print("Error: ${response['replyMsg']}");
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  static Future<bool?> createSubscription({
    required int courseID,
    required String price,
    required String courseName,
    required String transactionId,
  }) async {
    Map<String, dynamic> payload = {
      "course_id": courseID,
      "student_id": User().id,
      "transaction_id": transactionId,
      "price": price,
      "created_by": User().id,
      "student_name": User().name,
      "course_name": courseName,
      "phone": User().phone,
      "course_start_date": DateTime.now().toIso8601String()
    };

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.STUDENT_SUBSCRIPTION, payload);
      if (response['replyCode'] == 'success') {
        return true;
      } else {
        print("Error: ${response['replyMsg']}");
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  static Future<SubscriptionModel> checkStudentSubscription() async {
    Map<String, dynamic> payload = {'sid': User().sid};

    try {
      Map<String, dynamic> response = await BaseService.post(
          AppConstants.CHECK_STUDENT_SUBSCRIPTION, payload);
      if (response['replyCode'] == 'success') {
        return SubscriptionModel.fromJson(response);
      } else {
        print("Error: ${response['replyMsg']}");
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  static Future<PackageModel> getPackageList() async {
    Map<String, dynamic> payload = {};

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.PACKAGE_LIST, payload);
      if (response['replyCode'] == 'success') {
        if (response['data'].length > 0) {
          return PackageModel.fromJson(response['data'][0]);
        } else {
          throw Exception("No package available");
        }
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<CoursesListModel> getPackageCoursesList(int id) async {
    Map<String, dynamic> payload = {"package_id": id};

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.COURSES_LIST, payload);
      if (response['replyCode'] == 'success') {
        return CoursesListModel.fromJson(response);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
