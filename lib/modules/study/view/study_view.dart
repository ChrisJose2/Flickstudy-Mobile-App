import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:flutter_architecture/common/utilities/utils.dart';
import 'package:flutter_architecture/common/widgets/app_bar.dart';
import 'package:flutter_architecture/modules/study/view_models/study_view_model.dart';
import 'package:provider/provider.dart';

class StudyView extends StatefulWidget {
  @override
  StudyViewState createState() => StudyViewState();
}

class StudyViewState extends State<StudyView> {
  late StudyViewModel studyViewModel;
  ValueNotifier<String> imageNotifier =
      ValueNotifier<String>(AppConstants.HOME_STUDY_HOPE1);
  ValueNotifier<String> imageNotifier2 =
      ValueNotifier<String>(AppConstants.HOME_STUDY_HOPE3);
  Timer? timer;
  int index = 0;

  @override
  void initState() {
    studyViewModel = Provider.of<StudyViewModel>(context, listen: false);
    startImageAnimation();
    studyViewModel.getCourseSubjects();
    super.initState();
  }

  startImageAnimation() {
    Timer.periodic(Duration(seconds: 3), (_t) {
      index++;
      timer = _t;
      imageNotifier.value = index % 2 == 0
          ? AppConstants.HOME_STUDY_HOPE1
          : AppConstants.HOME_STUDY_HOPE2;
      imageNotifier2.value = index % 2 == 0
          ? AppConstants.HOME_STUDY_HOPE3
          : AppConstants.HOME_STUDY_HOPE4;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.home, (Route<dynamic> route) => false);
        return true;
      },
      child: Consumer<StudyViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarView(),
            body: studyViewModel.subjectsLoadingStatus
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Wrap(
                          //   spacing: 10,
                          //   runSpacing: 10,
                          //   children: [
                          //     for (var subject
                          //         in studyViewModel.courseSubjects!.subjectList)
                          //       subject.type == "subject"
                          //           ? Container(
                          //               color: Colors.red,
                          //               width: Utilities.textCardWidth(context),
                          //               child: GestureDetector(
                          //                 onTap: () {
                          //                   if (subject.subjectTitle ==
                          //                       "Words") {
                          //                     Navigator.pushNamed(
                          //                         context, AppRoutes.wordList);
                          //                   } else {
                          //                     Navigator.pushNamed(
                          //                         context, AppRoutes.chapter,
                          //                         arguments: subject.id);
                          //                   }
                          //                 },
                          //                 child: Utilities.getCardWithImageText(
                          //                     subject.subjectTitle,
                          //                     "assets/imgs/hamburger.png"),
                          //               ),
                          //             )
                          //           : Container(
                          //               width:
                          //                   Utilities.imageCardWidth(context),
                          //               child: Container(
                          //                 padding: EdgeInsets.all(5),
                          //                 decoration: BoxDecoration(
                          //                     borderRadius:
                          //                         BorderRadius.circular(16),
                          //                     color: Colors.white,
                          //                     boxShadow: [
                          //                       BoxShadow(
                          //                         color: Colors.black
                          //                             .withOpacity(
                          //                                 0.2), // Shadow color
                          //                         offset: Offset(2,
                          //                             2), // Offset (horizontal, vertical)
                          //                         blurRadius:
                          //                             2, // The blur effect of the shadow
                          //                         spreadRadius:
                          //                             0, // How much the shadow spreads
                          //                       ),
                          //                     ],
                          //                     border: Border.all(
                          //                         width: 0.8,
                          //                         color: Colors.grey.shade200)),
                          //                 child: Image.asset(
                          //                   "assets/imgs/place_holder_img.png",
                          //                   fit: BoxFit.cover,
                          //                   height: ((MediaQuery.of(context)
                          //                                   .size
                          //                                   .width -
                          //                               60) /
                          //                           3) -
                          //                       10,
                          //                 ),
                          //               ),
                          //             ),
                          //   ],
                          // ),
                          //

                          Wrap(
                            spacing: 8,
                            runSpacing: 10,
                            // textDirection: TextDirection.rtl,
                            children: [
                              for (int i = 0;
                                  i <
                                      studyViewModel
                                          .courseSubjects!.subjectList.length;
                                  i++)
                                if (i == 3)
                                  Row(
                                    children: [
                                      ValueListenableBuilder(
                                          valueListenable: imageNotifier,
                                          builder: (context, value, child) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              child: Image.network(
                                                imageNotifier.value,
                                                height:
                                                    (((MediaQuery.of(context)
                                                                        .size
                                                                        .width -
                                                                    60) /
                                                                3) *
                                                            2) +
                                                        10,
                                                width: (((MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            3) *
                                                        2) +
                                                    10,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            );
                                          }),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Container(
                                            width: Utilities.textCardWidth(
                                                context),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (studyViewModel
                                                        .courseSubjects!
                                                        .subjectList[3]
                                                        .subjectTitle ==
                                                    "Words") {
                                                  Navigator.pushNamed(context,
                                                      AppRoutes.wordList);
                                                } else {
                                                  Navigator.pushNamed(context,
                                                      AppRoutes.chapter,
                                                      arguments: studyViewModel
                                                          .courseSubjects!
                                                          .subjectList[3]
                                                          .id);
                                                }
                                              },
                                              child: Utilities
                                                  .getCardWithImageText(
                                                      studyViewModel
                                                          .courseSubjects!
                                                          .subjectList[3]
                                                          .subjectTitle,
                                                      studyViewModel
                                                          .courseSubjects!
                                                          .subjectList[3]
                                                          .image,
                                                      true),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            width: Utilities.textCardWidth(
                                                context),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (studyViewModel
                                                        .courseSubjects!
                                                        .subjectList[4]
                                                        .subjectTitle ==
                                                    "Words") {
                                                  Navigator.pushNamed(context,
                                                      AppRoutes.wordList);
                                                } else {
                                                  Navigator.pushNamed(context,
                                                      AppRoutes.chapter,
                                                      arguments: studyViewModel
                                                          .courseSubjects!
                                                          .subjectList[4]
                                                          .id);
                                                }
                                              },
                                              child: Utilities
                                                  .getCardWithImageText(
                                                      studyViewModel
                                                          .courseSubjects!
                                                          .subjectList[4]
                                                          .subjectTitle,
                                                      studyViewModel
                                                          .courseSubjects!
                                                          .subjectList[4]
                                                          .image,
                                                      true),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                else if (i != 4 && i != 8 && i != 9)
                                  Container(
                                    width: Utilities.textCardWidth(context),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (studyViewModel.courseSubjects!
                                                .subjectList[i].subjectTitle ==
                                            "Words") {
                                          Navigator.pushNamed(
                                              context, AppRoutes.wordList);
                                        } else {
                                          Navigator.pushNamed(
                                              context, AppRoutes.chapter,
                                              arguments: studyViewModel
                                                  .courseSubjects!
                                                  .subjectList[i]
                                                  .id);
                                        }
                                      },
                                      child: Utilities.getCardWithImageText(
                                          studyViewModel.courseSubjects!
                                              .subjectList[i].subjectTitle,
                                          studyViewModel.courseSubjects!
                                              .subjectList[i].image,
                                          true),
                                    ),
                                  )
                                else if (i == 8)
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              width: Utilities.textCardWidth(
                                                  context),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (studyViewModel
                                                          .courseSubjects!
                                                          .subjectList[8]
                                                          .subjectTitle ==
                                                      "Words") {
                                                    Navigator.pushNamed(context,
                                                        AppRoutes.wordList);
                                                  } else {
                                                    Navigator.pushNamed(context,
                                                        AppRoutes.chapter,
                                                        arguments:
                                                            studyViewModel
                                                                .courseSubjects!
                                                                .subjectList[8]
                                                                .id);
                                                  }
                                                },
                                                child: Utilities
                                                    .getCardWithImageText(
                                                        studyViewModel
                                                            .courseSubjects!
                                                            .subjectList[8]
                                                            .subjectTitle,
                                                        studyViewModel
                                                            .courseSubjects!
                                                            .subjectList[8]
                                                            .image,
                                                        true),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              width: Utilities.textCardWidth(
                                                  context),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (studyViewModel
                                                          .courseSubjects!
                                                          .subjectList[9]
                                                          .subjectTitle ==
                                                      "Words") {
                                                    Navigator.pushNamed(context,
                                                        AppRoutes.wordList);
                                                  } else {
                                                    Navigator.pushNamed(context,
                                                        AppRoutes.chapter,
                                                        arguments:
                                                            studyViewModel
                                                                .courseSubjects!
                                                                .subjectList[9]
                                                                .id);
                                                  }
                                                },
                                                child: Utilities
                                                    .getCardWithImageText(
                                                        studyViewModel
                                                            .courseSubjects!
                                                            .subjectList[9]
                                                            .subjectTitle,
                                                        studyViewModel
                                                            .courseSubjects!
                                                            .subjectList[9]
                                                            .image,
                                                        true),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        ValueListenableBuilder(
                                            valueListenable: imageNotifier2,
                                            builder: (context, value, child) {
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                child: Image.network(
                                                  imageNotifier2.value,
                                                  height:
                                                      (((MediaQuery.of(context)
                                                                          .size
                                                                          .width -
                                                                      60) /
                                                                  3) *
                                                              2) +
                                                          10,
                                                  width: (((MediaQuery.of(context)
                                                                      .size
                                                                      .width -
                                                                  60) /
                                                              3) *
                                                          2) +
                                                      10,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
