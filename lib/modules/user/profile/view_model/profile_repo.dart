import 'package:flutter_architecture/common/services/base_service.dart';
import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:flutter_architecture/modules/authentication/user_model.dart';

class ProfileRepo {
  static Future<bool> updateUserName(String name) async {
    Map<String, dynamic> payload = {"name": name, "id": User().id};

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.UPDATE_USER_PROFILE, payload);
      if (response['replyCode'] == 'success') {
        return true;
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
