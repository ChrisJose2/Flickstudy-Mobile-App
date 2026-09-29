import 'package:flutter/material.dart';
import 'package:flutter_architecture/modules/watchout/model/watchout_category_model.dart';
import 'package:flutter_architecture/modules/watchout/model/watchout_detail_model.dart';
import 'package:flutter_architecture/modules/watchout/model/watchout_list_model.dart';
import 'package:flutter_architecture/modules/watchout/view_model/watchout_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WatchOutViewModel extends ChangeNotifier {
  WatchOutViewModel._privateConstructor();

  static final WatchOutViewModel _instance =
      WatchOutViewModel._privateConstructor();

  factory WatchOutViewModel() {
    return _instance;
  }

  bool watchOutCategoryLoadingStatus = false;
  WatchOutCategoryListModel? watchOutCategoryList;

  Future<void> getWatchOutCategoryList() async {
    watchOutCategoryLoadingStatus = true;
    // notifyListeners();
    try {
      watchOutCategoryList = await WatchOutRepository.getWatchOutCategoryList();

      await Future.delayed(Duration(seconds: 1));
      watchOutCategoryLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      watchOutCategoryLoadingStatus = false;
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

  bool watchOutListLoadingStatus = false;
  WatchOutListModel? watchOutList;

  Future<void> getWatchOutList(int categoryId) async {
    watchOutListLoadingStatus = true;
    // notifyListeners();
    try {
      watchOutList = await WatchOutRepository.getWatchOutList(categoryId);
      await Future.delayed(Duration(seconds: 1));
      watchOutListLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      watchOutListLoadingStatus = false;
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

  bool watchOutDetailLoadingStatus = false;
  WatchOutDetailModel? watchOutDetail;

  Future<void> getWatchOutDetails(int id) async {
    watchOutDetailLoadingStatus = true;
    // notifyListeners();
    try {
      watchOutDetail = await WatchOutRepository.getWatchOutDetails(id);
      await Future.delayed(Duration(seconds: 1));
      watchOutDetailLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      watchOutDetailLoadingStatus = false;
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
}
