import 'package:flutter/material.dart';
import 'package:flutter_architecture/modules/authentication/login_with_otp/login_with_otp_view.dart';
import 'package:flutter_architecture/modules/authentication/register/register_view.dart';
import 'package:flutter_architecture/modules/authentication/verify_otp/view/verify_otp_view.dart';
import 'package:flutter_architecture/modules/buy_course/view/choose_course_view.dart';
import 'package:flutter_architecture/modules/notification/view/notification_list_view.dart';
import 'package:flutter_architecture/modules/plan/view/big_picture_view.dart';
import 'package:flutter_architecture/modules/plan/view/bookmark_question_view.dart';
import 'package:flutter_architecture/modules/plan/view/chapters_covered_view.dart';
import 'package:flutter_architecture/modules/plan/view/home_screen.dart';
import 'package:flutter_architecture/modules/plan/view/new_sub.dart';
import 'package:flutter_architecture/modules/plan/view/payment_failed.dart';
import 'package:flutter_architecture/modules/plan/view/payment_success_view.dart';
import 'package:flutter_architecture/modules/plan/view/study_calendar_view.dart';
import 'package:flutter_architecture/modules/plan/view/test_calendar_view.dart';
import 'package:flutter_architecture/modules/plan/view/test_completed_view.dart';
import 'package:flutter_architecture/modules/study/view/bookmark_view.dart';
import 'package:flutter_architecture/modules/study/view/chapter_view.dart';
import 'package:flutter_architecture/modules/study/view/comprehension_view.dart';
import 'package:flutter_architecture/modules/study/view/sub_topic_view.dart';
import 'package:flutter_architecture/modules/study/view/topic_view.dart';
import 'package:flutter_architecture/modules/study/view/video_view.dart';
import 'package:flutter_architecture/modules/study/view/quiz_view.dart';
import 'package:flutter_architecture/modules/study/view/word_detail_view.dart';
import 'package:flutter_architecture/modules/study/view/word_list_view.dart';
import 'package:flutter_architecture/modules/test/view/test_detail_view.dart';
import 'package:flutter_architecture/modules/test/view/test_list_view.dart';
import 'package:flutter_architecture/modules/test/view/test_questions_view.dart';
import 'package:flutter_architecture/modules/test/view/test_result_view.dart';
import 'package:flutter_architecture/modules/test/view/test_solution.dart';
import 'package:flutter_architecture/modules/test_analysis/view/test_analysis_view.dart';
import 'package:flutter_architecture/modules/user/profile/view/profile_view.dart';
import 'package:flutter_architecture/modules/watchout/view/watchout_detail_view.dart';
import 'package:flutter_architecture/modules/watchout/view/watchout_list_view.dart';
import 'package:flutter_architecture/modules/watchout/view/watchout_view.dart';
import 'package:flutter_architecture/splash_screen.dart';

import '../../modules/faq/view/faq_view.dart';
import '../../modules/plan/view/assessment_status_view.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String new_sub = '/subs';
  // static const String login = '/login';
  static const String login_with_otp = '/login_with_otp';
  static const String verify_otp = '/verify_otp';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String notification_list = '/notification_list';
  static const String study = '/study';
  static const String test = '/test';
  static const String chapter = '/chapter';
  static const String topic = '/topic';
  static const String subtopic = '/subtopic';
  static const String wordList = '/word_list';
  static const String wordDetail = '/word_detail';
  static const String comprehension = '/comprehension';
  static const String video = '/video';
  static const String quiz = '/quiz';
  static const String watchOut = '/watchout';
  static const String watchOutList = '/watchoutList';
  static const String watchOutDetail = '/watchoutDetail';
  static const String faq = '/faq';
  static const String big_picture = '/big_picture';
  static const String study_calendar = '/study_calendar';
  static const String chapters_covered = '/chapters_covered';
  static const String test_completed = '/test_completed';
  static const String test_calendar = '/test_calendar';
  static const String test_list = '/test_list';
  static const String chapter_test_list = '/chapter_test_list';
  static const String pre_test_list = '/pre_test_list';
  static const String full_subject_test_list = '/full_subject_test_list';
  static const String previous_year_paper_list = '/previous_year_paper_list';
  static const String test_detail = '/test_detail';
  static const String test_question = '/test_question';
  static const String test_result = '/test_result';
  static const String test_solution = '/test_solution';
  static const String choose_course = '/buy_course';
  static const String test_analysis = '/test_analysis';
  static const String bookmarkView = '/bookmark_view';
  static const String bookmark_question_view = '/bookmark_question_view';
  static const String payment_success = '/payment_success';
  static const String payment_failed = '/payment_failed';
  static const String assessment_status = '/assessment_status';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => SplashScreen(),
    home: (context) => MyHomePage(),
    new_sub: (context) => NewSub(),
    // login: (context) => LoginWithPasswordView(),
    login_with_otp: (context) => LoginWithOTPView(),
    verify_otp: (context) => VerifyOTPView(),
    register: (context) => RegisterView(),
    profile: (context) => ProfileView(),
    notification_list: (context) => NotificationListView(),
    chapter: (context) => ChapterView(),
    topic: (context) => TopicView(),
    subtopic: (context) => SubTopicView(),
    wordList: (context) => WordListView(),
    wordDetail: (context) => WordDetailView(),
    comprehension: (context) => ComprehensionView(),
    video: (context) {
      try {
        VideoArguments agr =
            ModalRoute.of(context)!.settings.arguments as VideoArguments;
        return VideoView(videoArguments: agr);
      } catch (e) {
        print(e);
        return VideoView(
            videoArguments: VideoArguments(
                videoLink: null,
                chapterId: null,
                subjectId: null,
                chapterTitle: null));
      }
    },
    quiz: (context) => const QuizView(),
    faq: (context) => FaqView(),
    watchOut: (context) => WatchoutView(),
    watchOutList: (context) => WatchOutListView(),
    watchOutDetail: (context) => WatchoutDetailView(),
    study_calendar: (context) => StudyCalendarView(),
    chapters_covered: (context) => ChaptersCoveredView(),
    test_completed: (context) => TestCompletedView(),
    test_calendar: (context) => TestCalendarView(),
    big_picture: (context) => BigPictureView(),
    test_list: (context) => TestListView(),
    chapter_test_list: (context) =>
        TestListView(initialArgs: const TestListArgs(type: null, title: "Chapter Test")),
    pre_test_list: (context) =>
        TestListView(initialArgs: const TestListArgs(type: 1, title: "Pre Test")),
    full_subject_test_list: (context) => TestListView(
        initialArgs: const TestListArgs(type: 2, title: "Full Subject Test")),
    previous_year_paper_list: (context) => TestListView(
        initialArgs: const TestListArgs(type: 3, title: "Previous year papers")),
    test_detail: (context) => TestDetailView(),
    test_question: (context) => TestQuestionView(),
    test_result: (context) => TestResultView(),
    test_solution: (context) => TestSolutionView(),
    test_analysis: (context) => TestAnalysisView(),
    choose_course: (context) => ChooseCourseView(),
    bookmarkView: (context) => BookmarkView(),
    bookmark_question_view: (context) => BookmarkQuestionView(),
    payment_success: (context) => PaymentSuccessView(),
    payment_failed: (context) => PaymentFailed(),
    assessment_status: (context) => AssessmentStatusView(),
  };
}

class VideoArguments {
  final String? videoLink;
  final int? chapterId;
  final int? subjectId;
  final String? chapterTitle;

  VideoArguments(
      {required this.videoLink,
      required this.chapterId,
      required this.subjectId,
      required this.chapterTitle});
}
