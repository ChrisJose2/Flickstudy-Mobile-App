import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/modules/study/models/chapter_model.dart';
import 'package:flutter_architecture/modules/study/view_models/study_view_model.dart';
import 'package:flutter_architecture/modules/user/user_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/styles/custom_text_styles.dart';
import '../../../common/widgets/text_widget.dart';

class StudyCalendarView extends StatefulWidget {
  StudyCalendarView({Key? key}) : super(key: key);

  @override
  State<StudyCalendarView> createState() => _StudyCalendarViewState();
}

class _StudyCalendarViewState extends State<StudyCalendarView> {
  late StudyViewModel studyViewModel;
  late int selectedSubjectIndex = -1;
  @override
  void initState() {
    studyViewModel = Provider.of<StudyViewModel>(context, listen: false);
    loadData();
    super.initState();
  }

  loadData() async {
    await studyViewModel.getCourseSubjects();
    if (studyViewModel.subjectsLoadingStatus == false &&
        (studyViewModel.courseSubjects?.subjectList.isNotEmpty ?? false)) {
      await studyViewModel.getSubjectChapters(
          courseId: studyViewModel.userPackage!.packageList[0].courses[0].id,
          subjectId: studyViewModel.courseSubjects!.subjectList[0].id);
      for (int i = 0;
          i < studyViewModel.subjectChapters!.chapterList.length;
          i++) {
        courseDates.add(DateTime.now());
      }
      selectedSubjectIndex = 0;
    }
  }

  List<DateTime> courseDates = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarViewV2(title: "Study Calendar"),
          body: studyViewModel.subjectsLoadingStatus ||
                  studyViewModel.chaptersLoadingStatus
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : selectedSubjectIndex == -1
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Subject dropdown removed per product request.
                          // SizedBox(height: 20),
                          // Row(
                          //   children: [
                          //     GestureDetector(
                          //       onTap: () {},
                          //       child: Container(
                          //         width: 150,
                          //         padding: EdgeInsets.all(5),
                          //         decoration: BoxDecoration(
                          //             border: Border.all(color: AppColors.grey),
                          //             borderRadius: BorderRadius.circular(5)),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             Expanded(
                          //                 child: Center(
                          //                     child: CustomTextField(
                          //               text: "Jan,2023",
                          //               styleFace: CustomTextStyles.b12,
                          //             ))),
                          //             Icon(Icons.arrow_drop_down)
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //         child: Container(
                          //       width: 100,
                          //       height: 1,
                          //       color: AppColors.grey,
                          //     ))
                          //   ],
                          // ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.flag),
                              SizedBox(
                                width: 20,
                              ),
                              CustomTextField(
                                text:
                                    "Started on ${DateFormat("dd MMM’yy").format(DateTime.parse(UserViewModel().studentSubscription!.data.first.courseStartDate))}",
                                styleFace: CustomTextStyles.thickb14,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: getTimelineUI(
                                studyViewModel.subjectChapters!.chapterList),
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }

  Widget getTimelineUI(List<Chapter> chapterList) {
    Widget contents(index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: CustomTextField(
                text: chapterList[index].chapterTitle,
                styleFace: CustomTextStyles.b12),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: AppColors.grey,
                  color: AppColors.primary,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CustomTextField(
                        text: '57%',
                        styleFace: CustomTextStyles.thickb12.primary),
                    SizedBox(
                      width: 20,
                    ),
                    CustomTextField(
                        text: '3 hours',
                        styleFace: CustomTextStyles.b12.darkGrey),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: chapterList.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          courseDates[index] = (DateTime.parse(
                  studyViewModel.userPackage!.packageList.first.created)
              .add(Duration(days: chapterList[index].days)));
        } else {
          courseDates[index] = (courseDates[index - 1]
              .add(Duration(days: chapterList[index].days)));
        }
        if (chapterList[index].type != "chapter") {
          return Container();
        }
        return Padding(
          padding: EdgeInsets.only(
              bottom: index == chapterList.length - 1 ? 0 : 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: AppColors.primary, width: 2)),
                    child: Column(
                      children: [
                        Container(
                          width: 32,
                          color: AppColors.primary,
                          child: Center(
                              child: CustomTextField(
                            text: DateFormat("MMM").format(courseDates[index]),
                            styleFace: CustomTextStyles.r12.white,
                          )),
                        ),
                        SizedBox(height: 2),
                        CustomTextField(
                          text: courseDates[index].day.toString(),
                          styleFace: CustomTextStyles.thickb14,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(width: 13.2),
              Expanded(child: contents(index)),
            ],
          ),
        );
      },
    );
  }

}
