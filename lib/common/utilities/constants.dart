import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConstants {
  static const TEST_RESULTS_BUCKET =
      "https://flik-study.s3.ap-south-1.amazonaws.com/test_results/";
  static const STATIC_IMAGES_BUCKET =
      "https://flik-study.s3.ap-south-1.amazonaws.com/";

  // Home Page Images
  static const String HOME_TEST_HOPE1 =
      "${STATIC_IMAGES_BUCKET}HopeImages/Home.Test.Hope1.jpg";
  static const String HOME_TEST_HOPE2 =
      "${STATIC_IMAGES_BUCKET}HopeImages/Home.Test.Hope2.jpg";
  static const String HOME_WATCH_HOPE1 =
      "${STATIC_IMAGES_BUCKET}HopeImages/Home.Watch.Hope1.jpg";
  static const String HOME_WATCH_HOPE2 =
      "${STATIC_IMAGES_BUCKET}HopeImages/Home.Watch.Hope2.jpg";
  static const String HOME_STUDY_HOPE3 =
      "${STATIC_IMAGES_BUCKET}HopeImages/Home.Study.Hope3.jpg";
  static const String HOME_STUDY_HOPE4 =
      "${STATIC_IMAGES_BUCKET}HopeImages/Home.Study.Hope4.jpg";
  static const String HOME_PLAN_HOPE1 =
      "${STATIC_IMAGES_BUCKET}HopeImages/Home.Plan.Hope1.jpg";
  static const String HOME_PLAN_HOPE2 =
      "${STATIC_IMAGES_BUCKET}HopeImages/Home.Plan.Hope2.jpg";
  static const String HOME_STUDY_HOPE1 =
      "${STATIC_IMAGES_BUCKET}HopeImages/Home.Study.Hope1.jpg";
  static const String HOME_STUDY_HOPE2 =
      "${STATIC_IMAGES_BUCKET}HopeImages/Home.Study.Hope2.jpg";

  //Plan Page Images
  static const String PLAN_STUDY_CALENDAR =
      "${STATIC_IMAGES_BUCKET}PlanImages/Plan.StudyCalendar.jpg";
  static const String PLAN_TEST_CALENDAR =
      "${STATIC_IMAGES_BUCKET}PlanImages/Plan.TestCalendar.jpg";
  static const String PLAN_CHAPTERS_COVERED =
      "${STATIC_IMAGES_BUCKET}PlanImages/Plan.ChaptersCovered.jpg";
  static const String PLAN_ASSESSMENT_STATUS =
      "${STATIC_IMAGES_BUCKET}PlanImages/Plan.AssessmentStatus.jpg";
  static const String PLAN_BOOKMARKED_QUESTIONS =
      "${STATIC_IMAGES_BUCKET}PlanImages/Plan.BookmarkedQuestions.jpg";
  static const String PLAN_TESTS_COMPLETED =
      "${STATIC_IMAGES_BUCKET}PlanImages/Plan.TestsCompleted.jpg";

  //Hope horizontal Images
  static const String HOPE_HORIZONTAL_1 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/1.jpg";
  static const String HOPE_HORIZONTAL_2 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/2.jpg";
  static const String HOPE_HORIZONTAL_3 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/3.jpg";
  static const String HOPE_HORIZONTAL_4 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/4.jpg";
  static const String HOPE_HORIZONTAL_5 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/5.jpg";
  static const String HOPE_HORIZONTAL_6 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/6.jpg";
  static const String HOPE_HORIZONTAL_7 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/7.jpg";
  static const String HOPE_HORIZONTAL_8 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/8.jpg";
  static const String HOPE_HORIZONTAL_9 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/9.jpg";
  static const String HOPE_HORIZONTAL_10 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/10.jpg";
  static const String HOPE_HORIZONTAL_11 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/11.jpg";
  static const String HOPE_HORIZONTAL_12 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/12.jpg";
  static const String HOPE_HORIZONTAL_13 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/13.jpg";
  static const String HOPE_HORIZONTAL_14 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/14.jpg";
  static const String HOPE_HORIZONTAL_15 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/15.jpg";
  static const String HOPE_HORIZONTAL_16 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/16.jpg";
  static const String HOPE_HORIZONTAL_17 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/17.jpg";
  static const String HOPE_HORIZONTAL_18 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/18.jpg";
  static const String HOPE_HORIZONTAL_19 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/19.jpg";
  static const String HOPE_HORIZONTAL_20 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/20.jpg";
  static const String HOPE_HORIZONTAL_21 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/21.jpg";
  static const String HOPE_HORIZONTAL_22 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/22.jpg";
  static const String HOPE_HORIZONTAL_23 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/23.jpg";
  static const String HOPE_HORIZONTAL_24 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/24.jpg";
  static const String HOPE_HORIZONTAL_25 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/25.jpg";
  static const String HOPE_HORIZONTAL_26 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/26.jpg";
  static const String HOPE_HORIZONTAL_27 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/27.jpg";
  static const String HOPE_HORIZONTAL_28 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/28.jpg";
  static const String HOPE_HORIZONTAL_29 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/29.jpg";
  static const String HOPE_HORIZONTAL_30 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/30.jpg";
  static const String HOPE_HORIZONTAL_31 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/31.jpg";
  static const String HOPE_HORIZONTAL_32 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/32.jpg";
  static const String HOPE_HORIZONTAL_33 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/33.jpg";
  static const String HOPE_HORIZONTAL_34 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/34.jpg";
  static const String HOPE_HORIZONTAL_35 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/35.jpg";
  static const String HOPE_HORIZONTAL_36 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/36.jpg";
  static const String HOPE_HORIZONTAL_37 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/37.jpg";
  static const String HOPE_HORIZONTAL_38 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/38.jpg";
  static const String HOPE_HORIZONTAL_39 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/39.jpg";
  static const String HOPE_HORIZONTAL_40 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/40.jpg";
  static const String HOPE_HORIZONTAL_41 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/41.jpg";
  static const String HOPE_HORIZONTAL_42 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/42.jpg";
  static const String HOPE_HORIZONTAL_43 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/43.jpg";
  static const String HOPE_HORIZONTAL_44 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/44.jpg";
  static const String HOPE_HORIZONTAL_45 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/45.jpg";
  static const String HOPE_HORIZONTAL_46 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/46.jpg";
  static const String HOPE_HORIZONTAL_47 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/47.jpg";
  static const String HOPE_HORIZONTAL_48 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/48.jpg";
  static const String HOPE_HORIZONTAL_49 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/49.jpg";
  static const String HOPE_HORIZONTAL_50 =
      "${STATIC_IMAGES_BUCKET}HopeImagesHorizontal/50.jpg";

  // List of all HOPE_HORIZONTAL images
  static const List<String> HOPE_HORIZONTAL_IMAGES = [
    HOPE_HORIZONTAL_1,
    HOPE_HORIZONTAL_2,
    HOPE_HORIZONTAL_3,
    HOPE_HORIZONTAL_4,
    HOPE_HORIZONTAL_5,
    HOPE_HORIZONTAL_6,
    HOPE_HORIZONTAL_7,
    HOPE_HORIZONTAL_8,
    HOPE_HORIZONTAL_9,
    HOPE_HORIZONTAL_10,
    HOPE_HORIZONTAL_11,
    HOPE_HORIZONTAL_12,
    HOPE_HORIZONTAL_13,
    HOPE_HORIZONTAL_14,
    HOPE_HORIZONTAL_15,
    HOPE_HORIZONTAL_16,
    HOPE_HORIZONTAL_17,
    HOPE_HORIZONTAL_18,
    HOPE_HORIZONTAL_19,
    HOPE_HORIZONTAL_20,
    HOPE_HORIZONTAL_21,
    HOPE_HORIZONTAL_22,
    HOPE_HORIZONTAL_23,
    HOPE_HORIZONTAL_24,
    HOPE_HORIZONTAL_25,
    HOPE_HORIZONTAL_26,
    HOPE_HORIZONTAL_27,
    HOPE_HORIZONTAL_28,
    HOPE_HORIZONTAL_29,
    HOPE_HORIZONTAL_30,
    HOPE_HORIZONTAL_31,
    HOPE_HORIZONTAL_32,
    HOPE_HORIZONTAL_33,
    HOPE_HORIZONTAL_34,
    HOPE_HORIZONTAL_35,
    HOPE_HORIZONTAL_36,
    HOPE_HORIZONTAL_37,
    HOPE_HORIZONTAL_38,
    HOPE_HORIZONTAL_39,
    HOPE_HORIZONTAL_40,
    HOPE_HORIZONTAL_41,
    HOPE_HORIZONTAL_42,
    HOPE_HORIZONTAL_43,
    HOPE_HORIZONTAL_44,
    HOPE_HORIZONTAL_45,
    HOPE_HORIZONTAL_46,
    HOPE_HORIZONTAL_47,
    HOPE_HORIZONTAL_48,
    HOPE_HORIZONTAL_49,
    HOPE_HORIZONTAL_50,
  ];

  // Get a random HOPE_HORIZONTAL image
  static String getRandomHopeHorizontal() {
    final random = Random();
    return HOPE_HORIZONTAL_IMAGES[
        random.nextInt(HOPE_HORIZONTAL_IMAGES.length)];
  }

  //Study Page Images
  static const String STUDY_HOPE1 =
      "${STATIC_IMAGES_BUCKET}HopeImages/Study.Hope1.jpg";

  static const REPORT_TYPE = "Report";
  static const FORM_TYPE = "Form";
  static const PLAN = "Plan";
  static const TEST = "Test";
  static const STUDY = "Study";
  static const TEST_ANALYSIS = "Analysis";

  // WhatsApp Configuration
  static const String WHATSAPP_NUMBER = "919481192168";

  //Const
  static const String GALLERY_FOLDER = "http://13.235.46.70/api/uploads/";
  //API
  static const String BASE_URL = "http://13.235.46.70:3001";
  static const String OTP_GENERATE = "/otp_generate";
  static const String USER_TOPIC_LESSON_LIST = "/user_topic_lesson_list";
  static const String LOGIN = "/login";
  static const String OTP_VERIFY = "/otp_verify";
  static const String USER_PACKAGE_DETAILS = "/user_package_details";
  static const String USER_SUBJECTS_CHAPTERS = "/user_subjects_chapters";
  static const String USER_COURSE_SUBJECTS = "/user_course_subjects";
  static const String USER_BLOG_CATEGORY_LIST = "/user_blog_category_list";
  static const String USER_BLOG_LIST = "/user_blog_list";
  static const String BLOG_DETAILS = "/blog_details";
  static const String USER_WORDLIST_LIST = "/user_wordlist_list";
  static const String USER_WORD_DETAILS = "/user_word_details";
  static const String ADD_BOOKMARK_WORD = "/add_bookmark_word";
  static const String BOOKMARK_WORD_LIST = "/bookmark_word_list";
  static const String DELETE_BOOKMARK_WORD = "/delete_bookmark_word";
  static const String GET_USER_CHAPTER_SESSIONS_LIST =
      "/user_chapter_sessions_list";
  static const String ADD_USER_CHAPTER_SESSIONS = "/user_chapter_sessions";

  static const String UPLOAD_FILE = "/upload_file";
  static const String REGISTER_USER = "/register_user";
  static const String USER_COURSES_DETAILS = "/user_courses_details";

  static const String UPDATE_USER_PROFILE = "/update_user_profile";
  static const String UPDATE_PROFILE_IMAGE = "/update_profile_image";
  static const String USER_PROFILE_DETAILS = "/user_profile_details";

  ///SUBSCRIPTION
  static const String STUDENT_SUBSCRIPTION = "/student_subscription";
  static const String CHECK_STUDENT_SUBSCRIPTION =
      "/check_student_subscription";
  static const String PACKAGE_LIST = "/package_list";
  static const String COURSES_LIST = "/courses_list";

  ///TEST
  static const String USER_TEST_PAPER_LIST = "/user_test_paper_list";
  static const String TESTPAPER_DETAIL = "/testpaper_detail";
  static const String TESTPAPER_QUESTION_LIST = "/testpaper_questions";
  static const String USER_TEST_PAPER_SESSIONS = "/user_testpaper_sessions";

  ///QUESTION
  static const String BOOKMARK_QUESTION_LIST =
      "/bookmark_question_list"; //user_id:1,question_id:1
  static const String ADD_BOOKMARK_QUESTION =
      "/add_bookmark_question"; //user_id:1,question_id:1

  static const String REMOVE_BOOKMARK_QUESTION =
      "/remove_bookmark_question"; //user_id:1,question_id:1,id:1

  static const String USER_TEST_PAPER_SUBMISSIONS =
      "/user_testpaper_submissions";

  ///CMS
  static const String CMS_DETAILS = "/cms_details";
  static Future<bool> checkInternetConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.vpn) {
      return true;
    } else {
      return false;
    }
  }

  static launchUrl(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
}

class TestEvents {
  //TEST_STARTED
  // TEST_COMPLETED
  // QUESTION_SKIPPED
  // QUESTION_ANSWERED
  // SUMMARY_OPENED
  // TEST_QUIT
  // QUESTION_STARTED

  static const String TEST_STARTED = "TEST_STARTED";
  static const String TEST_COMPLETED = "TEST_COMPLETED";
  static const String QUESTION_SKIPPED = "QUESTION_SKIPPED";
  static const String QUESTION_ANSWERED = "QUESTION_ANSWERED";
  static const String SUMMARY_OPENED = "SUMMARY_OPENED";
  static const String TEST_QUIT = "TEST_QUIT";
  static const String QUESTION_STARTED = "QUESTION_STARTED";
}
