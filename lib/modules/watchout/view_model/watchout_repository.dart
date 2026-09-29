import 'package:flutter_architecture/common/services/base_service.dart';
import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:flutter_architecture/modules/watchout/model/watchout_category_model.dart';
import 'package:flutter_architecture/modules/watchout/model/watchout_detail_model.dart';
import 'package:flutter_architecture/modules/watchout/model/watchout_list_model.dart';

class WatchOutRepository {
  static Future<WatchOutCategoryListModel> getWatchOutCategoryList() async {
    Map<String, dynamic> payload = {};

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.USER_BLOG_CATEGORY_LIST, payload);
      if (response['replyCode'] == 'success') {
        return WatchOutCategoryListModel.fromJson(response);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<WatchOutListModel> getWatchOutList(int categoryId) async {
    Map<String, dynamic> payload = {"blog_category_id": categoryId};

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.USER_BLOG_LIST, payload);
      if (response['replyCode'] == 'success') {
        return WatchOutListModel.fromJson(response);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<WatchOutDetailModel> getWatchOutDetails(int id) async {
    Map<String, dynamic> payload = {"id": id};

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.BLOG_DETAILS, payload);
      if (response['replyCode'] == 'success') {
        return WatchOutDetailModel.fromJson(response['data']);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
