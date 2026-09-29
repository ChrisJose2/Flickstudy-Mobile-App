import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/main.dart';
import 'package:flutter_architecture/modules/study/models/bookmark_list_model.dart';
import 'package:flutter_architecture/modules/study/models/chapter_model.dart';
import 'package:flutter_architecture/modules/study/models/subject_model.dart';
import 'package:flutter_architecture/modules/study/models/subject_session_model.dart';
import 'package:flutter_architecture/modules/study/models/topic_model.dart';
import 'package:flutter_architecture/modules/study/models/user_package_detail_model.dart';
import 'package:flutter_architecture/modules/study/models/word_detail_model.dart';
import 'package:flutter_architecture/modules/study/models/word_list_model.dart';
import 'package:flutter_architecture/modules/study/view_models/study_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StudyViewModel extends ChangeNotifier {
  StudyViewModel._privateConstructor();

  static final StudyViewModel _instance = StudyViewModel._privateConstructor();

  factory StudyViewModel() {
    return _instance;
  }

  UserPackageModel? userPackage;

  Future<void> getUserPackage() async {
    try {
      userPackage = await StudyRepository.getUserPackage();
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

  bool subjectsLoadingStatus = false;
  UserSubjectModel? courseSubjects;

  Future<void> getCourseSubjects() async {
    subjectsLoadingStatus = true;
    // notifyListeners();
    try {
      if (userPackage == null) {
        await Future.delayed(Duration(seconds: 5));
      }
      courseSubjects = await StudyRepository.getCourseSubjects(
          courseId: userPackage!.packageList[0].courses[0].id);
      // if (courseSubjects!.subjectList.length > 4) {
      //   courseSubjects!.subjectList.insert(
      //       4,
      //       Subject(
      //           id: 0,
      //           sNo: 0,
      //           courseId: 0,
      //           subjectTitle: "",
      //           subjectDescription: "",
      //           createdBy: 0,
      //           status: 0,
      //           created: "",
      //           image: "",
      //           type: "image"));
      //   courseSubjects!.subjectList.insert(
      //       8,
      //       Subject(
      //           id: 0,
      //           sNo: 0,
      //           courseId: 0,
      //           subjectTitle: "",
      //           subjectDescription: "",
      //           createdBy: 0,
      //           status: 0,
      //           created: "",
      //           image: "",
      //           type: "image"));
      // } else {
      //   courseSubjects!.subjectList.insert(
      //       courseSubjects!.subjectList.length,
      //       Subject(
      //           id: 0,
      //           sNo: 0,
      //           courseId: 0,
      //           subjectTitle: "",
      //           subjectDescription: "",
      //           createdBy: 0,
      //           status: 0,
      //           created: "",
      //           image: "",
      //           type: "image"));
      // }
      await Future.delayed(Duration(seconds: 1));
      subjectsLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      subjectsLoadingStatus = false;
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

  ChapterModel? subjectChapters;
  bool chaptersLoadingStatus = false;

  Future<void> getSubjectChapters(
      {required int courseId, required int subjectId}) async {
    chaptersLoadingStatus = true;
    // notifyListeners();
    try {
      subjectChapters = await StudyRepository.getSubjectChapters(
          courseId: courseId, subjectId: subjectId);
      if (subjectChapters!.chapterList.length > 4) {
        subjectChapters!.chapterList.insert(
            4,
            Chapter(
                id: 0,
                sNo: 0,
                subjectId: subjectId,
                chapterTitle: "",
                chapterDescription: "",
                days: 0,
                createdBy: 0,
                status: 0,
                image: "",
                created: "",
                type: "image"));
        if (subjectChapters!.chapterList.length > 8) {
          subjectChapters!.chapterList.insert(
              8,
              Chapter(
                  id: 0,
                  sNo: 0,
                  subjectId: subjectId,
                  chapterTitle: "",
                  chapterDescription: "",
                  image: "",
                  days: 0,
                  createdBy: 0,
                  status: 0,
                  created: "",
                  type: "image"));
        }
      } else {
        subjectChapters!.chapterList.insert(
            subjectChapters!.chapterList.length,
            Chapter(
                id: 0,
                sNo: 0,
                subjectId: subjectId,
                chapterTitle: "",
                chapterDescription: "",
                image: "",
                days: 0,
                createdBy: 0,
                status: 0,
                created: "",
                type: "image"));
      }
      await Future.delayed(Duration(seconds: 1));
      chaptersLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      chaptersLoadingStatus = false;
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

  TopicModel? chapterTopics;
  bool topicsLoadingStatus = false;

  Future<void> getChapterTopics({required int chapterId}) async {
    topicsLoadingStatus = true;
    // notifyListeners();
    try {
      chapterTopics =
          await StudyRepository.getChapterTopics(chapterId: chapterId);
      await Future.delayed(Duration(seconds: 1));
      topicsLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      topicsLoadingStatus = false;
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

  SubjectSessionModel? userChapterSessions;
  bool userChapterSessionsLoadingStatus = false;

  Future<void> getUserChapterSessionsList(int subjectId) async {
    userChapterSessionsLoadingStatus = true;
    // notifyListeners();
    try {
      userChapterSessions =
          await StudyRepository.getUserChapterSessionsList(subjectId);
      await Future.delayed(Duration(seconds: 1));
      notifyListeners();
    } catch (e) {
      userChapterSessionsLoadingStatus = false;
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

  Future<bool> addChapterSessions(
      {required int chapterId,
      required int subjectId,
      required String chapterTitle,
      required double completed}) async {
    try {
      bool result = await StudyRepository.addChapterSessions(
          chapterId: chapterId,
          subjectId: subjectId,
          chapterTitle: chapterTitle,
          completed: completed);
      return result;
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

  WordListModel? wordListData;
  bool wordListLoadingStatus = false;
  bool isListFiltered = false;

  Future<void> getWordList(
      {required int startIndex, required int endIndex}) async {
    wordListLoadingStatus = true;
    notifyListeners();
    try {
      wordListData = await StudyRepository.getWordList();
      wordListData!.wordList.sort((a, b) => a.title.compareTo(b.title));
      await generateFilteredList(startIndex: startIndex, endIndex: endIndex);
      if (startIndex > 0 || endIndex < 25) {
        isListFiltered = true;
      } else {
        isListFiltered = false;
      }
      await Future.delayed(Duration(seconds: 1));
      wordListLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      wordListLoadingStatus = false;
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

  List<AlphabetListViewItemGroup> alphabeticWordList = [];
  List<AlphabetListViewItemGroup> tempAlphabeticWordList = [];
  generateFilteredList({required int startIndex, required int endIndex}) {
    alphabeticWordList = [];
    tempAlphabeticWordList = [];
    Map<String, List<String>> subLists = {};
    String firstAlphabet = "";
    wordListData!.wordList.forEach((element) {
      if (element.title.substring(0, 1).toUpperCase() == firstAlphabet) {
        subLists[firstAlphabet]!.add(element.title);
      } else {
        subLists.addEntries({
          MapEntry(element.title.substring(0, 1).toUpperCase(), [element.title])
        });
      }
      firstAlphabet = element.title.substring(0, 1).toUpperCase();
    });
    subLists.forEach((key, value) {
      alphabeticWordList.add(
        AlphabetListViewItemGroup(
          tag: key,
          children: [
            for (String word in value)
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, AppRoutes.wordDetail,
                      arguments: {
                        "wordList": wordListData!.wordList,
                        "selectedIndex": wordListData!.wordList
                            .indexWhere((element) => element.title == word)
                      });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    word,
                    style: CustomTextStyles.thickb14,
                  ),
                ),
              )
          ],
        ),
      );
    });
    tempAlphabeticWordList.addAll(alphabeticWordList);
    try {
      alphabeticWordList.removeRange(endIndex + 1, alphabeticWordList.length);
      alphabeticWordList.removeRange(0, startIndex);
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to set filter");
      alphabeticWordList.clear();
      alphabeticWordList.addAll(tempAlphabeticWordList);
      isListFiltered = false;
    }
  }

  WordDetailsModel? wordDetails;
  bool wordDetailsLoadingStatus = false;

  Future<void> getWordDetails({required int wordId}) async {
    wordDetailsLoadingStatus = true;
    // notifyListeners();
    try {
      wordDetails = await StudyRepository.getWordDetails(wordId: wordId);
      await Future.delayed(Duration(seconds: 1));
      wordDetailsLoadingStatus = false;
      notifyListeners();
    } catch (e) {
      wordDetailsLoadingStatus = false;
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

  BookmarkListModel? bookmarkList;
  bool bookmarkListLoadingStatus = false;

  Future<void> getBookmarkList() async {
    bookmarkListLoadingStatus = true;
    // notifyListeners();
    try {
      bookmarkList = await StudyRepository.getBookmarkList();
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

  Future<bool> addBookmarkWord({required int wordId}) async {
    try {
      return await StudyRepository.addBookmarkWord(wordId: wordId);
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

  Future<bool> deleteBookmarkWord(
      {required int id, required int wordId}) async {
    try {
      return await StudyRepository.deleteBookmarkWord(id: id, wordId: wordId);
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
}
