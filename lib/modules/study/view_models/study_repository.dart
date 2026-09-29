import 'package:flutter_architecture/common/services/base_service.dart';
import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:flutter_architecture/modules/authentication/user_model.dart';
import 'package:flutter_architecture/modules/study/models/bookmark_list_model.dart';
import 'package:flutter_architecture/modules/study/models/chapter_model.dart';
import 'package:flutter_architecture/modules/study/models/subject_model.dart';
import 'package:flutter_architecture/modules/study/models/subject_session_model.dart';
import 'package:flutter_architecture/modules/study/models/topic_model.dart';
import 'package:flutter_architecture/modules/study/models/user_package_detail_model.dart';
import 'package:flutter_architecture/modules/study/models/word_detail_model.dart';
import 'package:flutter_architecture/modules/study/models/word_list_model.dart';

class StudyRepository {
  static Future<UserPackageModel> getUserPackage() async {
    Map<String, dynamic> payload = {"package_id": "1"};

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.USER_PACKAGE_DETAILS, payload);
      if (response['replyCode'] == 'success') {
        return UserPackageModel.fromJson(response);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<UserSubjectModel> getCourseSubjects(
      {required int courseId}) async {
    Map<String, dynamic> payload = {"course_id": courseId};

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.USER_COURSE_SUBJECTS, payload);
      if (response['replyCode'] == 'success') {
        return UserSubjectModel.fromJson(response);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<ChapterModel> getSubjectChapters(
      {required int courseId, required int subjectId}) async {
    Map<String, dynamic> payload = {
      "course_id": courseId,
      "subject_id": subjectId
    };

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.USER_SUBJECTS_CHAPTERS, payload);
      if (response['replyCode'] == 'success') {
        return ChapterModel.fromJson(response);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<TopicModel> getChapterTopics({required int chapterId}) async {
    Map<String, dynamic> payload = {"chapter_id": chapterId};

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.USER_TOPIC_LESSON_LIST, payload);
      if (response['replyCode'] == 'success') {
        return TopicModel.fromJson(response);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> addChapterSessions(
      {required int chapterId,
      required int subjectId,
      required String chapterTitle,
      required double completed}) async {
    Map<String, dynamic> payload = {
      "sid": User().sid,
      "chapter_id": chapterId,
      "chapter_name": chapterTitle,
      "subject_id": subjectId,
      "percentage_completion": completed,
    };

    try {
      Map<String, dynamic> response = await BaseService.post(
          AppConstants.ADD_USER_CHAPTER_SESSIONS, payload);
      if (response['replyCode'] == 'success') {
        return true;
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<SubjectSessionModel> getUserChapterSessionsList(
      int subjectId) async {
    Map<String, dynamic> payload = {"sid": User().sid, "subject_id": subjectId};

    try {
      Map<String, dynamic> response = await BaseService.post(
          AppConstants.GET_USER_CHAPTER_SESSIONS_LIST, payload);
      if (response['replyCode'] == 'success') {
        return SubjectSessionModel.fromJson(response);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<WordListModel> getWordList() async {
    Map<String, dynamic> payload = {
      "keyword": "",
      "start": "",
      "end": "",
    };

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.USER_WORDLIST_LIST, payload);
      if (response['replyCode'] == 'success') {
        return WordListModel.fromJson(response);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<WordDetailsModel> getWordDetails({required int wordId}) async {
    Map<String, dynamic> payload = {"id": wordId};

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.USER_WORD_DETAILS, payload);
      if (response['replyCode'] == 'success') {
        int? bookmarkId = await checkWordBookmark(wordId: wordId);
        return WordDetailsModel.fromJson(response, bookmarkId);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<int?> checkWordBookmark({required int wordId}) async {
    BookmarkListModel bookmarkList = await getBookmarkList();
    if (bookmarkList.bookmarkList
        .where((element) => element.wordId == wordId)
        .isNotEmpty) {
      return (bookmarkList.bookmarkList
          .where((element) => element.wordId == wordId)
          .first
          .id);
    } else {
      return null;
    }
  }

  static Future<BookmarkListModel> getBookmarkList() async {
    Map<String, dynamic> payload = {"user_id": User().id};

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.BOOKMARK_WORD_LIST, payload);
      if (response['replyCode'] == 'success') {
        return BookmarkListModel.fromJson(response);
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> addBookmarkWord({required int wordId}) async {
    Map<String, dynamic> payload = {"word_id": wordId, "user_id": User().id};

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.ADD_BOOKMARK_WORD, payload);
      if (response['replyCode'] == 'success') {
        return true;
      } else {
        throw Exception(response['replyMsg']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> deleteBookmarkWord(
      {required int id, required int wordId}) async {
    Map<String, dynamic> payload = {
      "id": id,
      "word_id": wordId,
      "user_id": User().id
    };

    try {
      Map<String, dynamic> response =
          await BaseService.post(AppConstants.DELETE_BOOKMARK_WORD, payload);
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
