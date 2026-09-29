import 'package:flutter_architecture/common/services/base_service.dart';
import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:flutter_architecture/modules/authentication/user_model.dart';
import 'package:flutter_architecture/modules/test/model/bookmark_question_model.dart';
import 'package:flutter_architecture/modules/test/model/test_calender_model.dart';
import 'package:flutter_architecture/modules/test/model/test_detail_model.dart';
import 'package:flutter_architecture/modules/test/model/test_questions_model.dart';
import 'package:flutter_architecture/modules/test/model/test_result_model.dart';
import 'package:flutter_architecture/modules/test/model/test_sessions_model.dart';

class TestRepository {
  static Future<TestCalenderModel> getTestCalenderList(
      {required int courseId,
      required int? subjectId,
      required int? type}) async {
    Map<String, dynamic> payload = {
      "course_id": courseId,
      if (subjectId != null) "subject_id": subjectId,
      if (type != null) "type": type
    };

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.USER_TEST_PAPER_LIST, payload);
      if (response['replyCode'] == 'success') {
        return TestCalenderModel.fromJson(response);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<TestDetailModel> getTestPaperDetails(
      {required String? keyword, required int testId}) async {
    Map<String, dynamic> payload = {
      "keyword": keyword ?? "",
      "testpaper_id": testId
    };

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.TESTPAPER_DETAIL, payload);
      if (response['replyCode'] == 'success') {
        return TestDetailModel.fromJson(response);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<TestQuestionsModel> getTestPaperQuestionList(
      {required String? keyword, required int testId}) async {
    Map<String, dynamic> payload = {
      "keyword": keyword ?? "",
      "testpaper_id": testId
    };

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.TESTPAPER_QUESTION_LIST, payload);
      if (response['replyCode'] == 'success') {
        return TestQuestionsModel.fromJson(response);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<BookmarkQuestionModel> getBookmarkQuestion() async {
    Map<String, dynamic> payload = {
      "user_id": User().id,
    };

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.BOOKMARK_QUESTION_LIST, payload);
      if (response['replyCode'] == 'success') {
        return BookmarkQuestionModel.fromJson(response);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> addBookmarkQuestion({required int questionId}) async {
    Map<String, dynamic> payload = {
      "user_id": User().id,
      "question_id": questionId
    };

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.ADD_BOOKMARK_QUESTION, payload);
      if (response['replyCode'] == 'success') {
        return true;
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> removeBookmarkQuestion(
      {required int id, required String questionId}) async {
    Map<String, dynamic> payload = {
      "id": id,
      "question_id": questionId,
      "user_id": User().id
    };

    try {
      Map<String, dynamic> response = await BaseService.post(
          AppConstants.REMOVE_BOOKMARK_QUESTION, payload);
      if (response['replyCode'] == 'success') {
        return true;
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> saveUserTestPaperSessions({
    required int testPaperId,
    required String userId,
    required String? questionCode,
    required String sessionId,
    required String eventName,
    required bool? isCorrect,
    required int? subjectId,
    required dynamic extraData,
  }) async {
    dynamic payload = {
      "testpaper_id": testPaperId,
      "user_id": userId,
      "question_code": questionCode,
      "session_id": sessionId,
      "event_name": eventName,
      "extra_data": extraData,
      "is_correct": isCorrect == null
          ? null
          : isCorrect
              ? 1
              : 0,
      "subject_id": subjectId,
    };

    try {
      Map<String, dynamic> response = await BaseService.post(
          AppConstants.USER_TEST_PAPER_SESSIONS, payload);
      if (response['replyCode'] == 'success') {
        return true;
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<TestResultModel> getTestResult(
      {required String testSessionId}) async {
    TestResultModel testResultModel = TestResultModel();

    try {
      Map<String, dynamic> response = await BaseService.rawGet(
          AppConstants.TEST_RESULTS_BUCKET +
              User().id +
              "/session_" +
              testSessionId +
              ".json");
      testResultModel.fromJson(response);
      return testResultModel;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<TestSessionModel>> getTestSessionList() async {
    TestSessionsResponse testSessionsResponse = TestSessionsResponse();
    Map<String, dynamic> payload = {"sid": User().sid};

    try {
      Map<String, dynamic> response = await BaseService.post(
          AppConstants.USER_TEST_PAPER_SUBMISSIONS, payload);
      if (response['replyCode'] == 'success') {
        testSessionsResponse.fromJson(response['data']);
        try {
          return testSessionsResponse.testSessions;
        } catch (ex) {
          print("ex" + ex.toString());
          throw Exception(ex);
        }
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
