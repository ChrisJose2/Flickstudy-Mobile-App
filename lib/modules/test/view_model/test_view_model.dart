import 'package:flutter/material.dart';
import 'package:flutter_architecture/modules/authentication/user_model.dart';
import 'package:flutter_architecture/modules/test/model/bookmark_question_model.dart';
import 'package:flutter_architecture/modules/test/model/test_calender_model.dart';
import 'package:flutter_architecture/modules/test/model/test_detail_model.dart';
import 'package:flutter_architecture/modules/test/model/test_questions_model.dart';
import 'package:flutter_architecture/modules/test/model/test_result_model.dart';
import 'package:flutter_architecture/modules/test/model/test_sessions_model.dart';
import 'package:flutter_architecture/modules/test/view_model/test_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TestViewModel extends ChangeNotifier {
  TestViewModel._privateConstructor();

  List<TestSessionModel> testSessions = [];
  static final TestViewModel _instance = TestViewModel._privateConstructor();
  String sessionId = "";
  //Create a new test sessionId
  createSessionId() {
    //return alphanumeric sessionId with 10 characters including sid of the user
    sessionId = "${User().sid}_${DateTime.now().millisecondsSinceEpoch}";
  }

  factory TestViewModel() {
    return _instance;
  }
  bool testCalenderLoadingStatus = false;
  TestCalenderModel? testCalenderModel;

  // Monotonic counter used to discard stale responses when the user navigates
  // between test types quickly. Without this, a slow earlier response can land
  // after a newer one and overwrite the correct list.
  int _testCalenderFetchSeq = 0;

  Future<void> getTestCalenderList(
      {required int courseId,
      required int? subjectId,
      required int? type}) async {
    final mySeq = ++_testCalenderFetchSeq;
    testCalenderLoadingStatus = true;
    // Drop any cached list so consumers gate on null while the new fetch runs.
    testCalenderModel = null;
    notifyListeners();
    try {
      final result = await TestRepository.getTestCalenderList(
          courseId: courseId, subjectId: subjectId, type: type);
      if (mySeq != _testCalenderFetchSeq) {
        // A newer fetch has already started — discard this stale response so it
        // doesn't overwrite the correct list.
        return;
      }
      testCalenderModel = result;
      testCalenderLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      if (mySeq != _testCalenderFetchSeq) return;
      testCalenderLoadingStatus = false;
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

  bool testDetailLoadingStatus = false;
  TestDetailModel? testDetail;

  Future<void> getTestDetail(
      {required String? keyword, required int testId}) async {
    testDetailLoadingStatus = true;
    // notifyListeners();
    try {
      testDetail = await TestRepository.getTestPaperDetails(
          keyword: keyword, testId: testId);
      await Future.delayed(Duration(seconds: 1));
      testDetailLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      testDetailLoadingStatus = false;
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

  bool testQuestionsLoadingStatus = false;
  TestQuestionsModel? testQuestionsList;

  Future<void> getTestPaperQuestionList(
      {required String? keyword, required int testId}) async {
    testQuestionsLoadingStatus = true;
    // notifyListeners();
    try {
      testQuestionsList = await TestRepository.getTestPaperQuestionList(
          keyword: keyword, testId: testId);
      await Future.delayed(Duration(seconds: 1));
      testQuestionsLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      testQuestionsLoadingStatus = false;
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

  BookmarkQuestionModel? bookmarkQuestionList;
  bool bookmarkListLoadingStatus = false;

  Future<void> getBookmarkQuestionList() async {
    bookmarkListLoadingStatus = true;
    // notifyListeners();
    try {
      bookmarkQuestionList = await TestRepository.getBookmarkQuestion();
      await Future.delayed(Duration(seconds: 1));
      bookmarkListLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      bookmarkListLoadingStatus = false;
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

  Future<bool> addBookmarkQuestion({required int questionId}) async {
    try {
      return await TestRepository.addBookmarkQuestion(questionId: questionId);
    } catch (e) {
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

  Future<bool> removeBookmarkQuestion(
      {required int id, required String questionId}) async {
    try {
      return await TestRepository.removeBookmarkQuestion(
          id: id, questionId: questionId);
    } catch (e) {
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

  Future<bool> saveUserTestPaperSessions({
    required int testPaperId,
    required String? questionCode,
    required String eventName,
    required int? subjectId,
    required bool? isCorrect,
    required dynamic extraData,
  }) async {
    try {
      bool response = await TestRepository.saveUserTestPaperSessions(
          testPaperId: testPaperId,
          userId: User().id,
          questionCode: questionCode,
          sessionId: sessionId,
          eventName: eventName,
          subjectId: subjectId,
          isCorrect: isCorrect,
          extraData: extraData);
      return response;
    } catch (e) {
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

  TestResultModel? testResult;
  Future<void> getTestResult() async {
    try {
      testResult = await TestRepository.getTestResult(testSessionId: sessionId);
      sessionId = "0";
      notifyListeners();
    } catch (e) {
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

  Future<void> getTestResultWithOverall() async {
    try {
      testResult = await TestRepository.getTestResult(testSessionId: sessionId);
      SubjectModel subject = SubjectModel();
      subject.fromParent("Overall", testResult!.testResultItemModel);
      //add this to the top of the list
      testResult!.subjects.insert(0, subject);

      sessionId = "0";
      notifyListeners();
    } catch (e) {
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

  List<TestSessionModel> testSessionList = [];
  Future<void> getTestSessionList() async {
    try {
      testSessionList = await TestRepository.getTestSessionList();
      notifyListeners();
    } catch (e) {
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

  List<Map<int, int>> testAnswers = [];
}
