import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/modules/study/view_models/study_view_model.dart';
import 'package:flutter_architecture/modules/test/model/test_calender_model.dart';
import 'package:flutter_architecture/modules/test/view_model/test_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/styles/custom_text_styles.dart';
import '../../../common/widgets/text_widget.dart';

class TestCalendarView extends StatefulWidget {
  TestCalendarView({Key? key}) : super(key: key);

  @override
  State<TestCalendarView> createState() => _TestCalendarViewState();
}

class _TestCalendarViewState extends State<TestCalendarView> {
  late StudyViewModel studyViewModel;
  late TestViewModel testViewModel;

  late int selectedTestTypeIndex = -1;

  @override
  void initState() {
    studyViewModel = Provider.of<StudyViewModel>(context, listen: false);
    testViewModel = Provider.of<TestViewModel>(context, listen: false);
    loadData();
    super.initState();
  }

  loadData() async {
    await studyViewModel.getCourseSubjects();
    if (studyViewModel.subjectsLoadingStatus == false &&
        (studyViewModel.courseSubjects?.subjectList.isNotEmpty ?? false)) {
      await Future.wait([
        studyViewModel.getSubjectChapters(
            courseId: studyViewModel.userPackage!.packageList[0].courses[0].id,
            subjectId: studyViewModel.courseSubjects!.subjectList[0].id),
        testViewModel.getTestCalenderList(
            courseId: studyViewModel.userPackage!.packageList[0].courses[0].id,
            subjectId: null,
            type: testTypeList[0].id),
      ]);

      // Size courseDates to match testData (the timeline iterates over testData,
      // not chapterList — using the wrong list length here was causing
      // RangeError when testData was longer than chapterList).
      courseDates
        ..clear()
        ..addAll(List<DateTime>.filled(
            testViewModel.testCalenderModel?.testData.length ?? 0,
            DateTime.now()));

      selectedTestTypeIndex = 0;
      setState(() {});
    }
  }

  List<DateTime> courseDates = [];

  Map<int, String> weekDays = {
    1: "Mon",
    2: "Tue",
    3: "Wed",
    4: "Thu",
    5: "Fri",
    6: "Sat",
    7: "Sun",
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<TestViewModel>(builder: (context, viewModel, child) {
      return Consumer<StudyViewModel>(builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarViewV2(title: "Test Calendar"),
          body: studyViewModel.subjectsLoadingStatus ||
                  studyViewModel.chaptersLoadingStatus ||
                  testViewModel.testCalenderLoadingStatus
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : selectedTestTypeIndex == -1
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
                          // Subject/test-type dropdown removed per product request.
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
                                    "Started on ${DateFormat("dd MMM’yy").format(DateTime.parse(studyViewModel.userPackage!.packageList.first.created))}",
                                styleFace: CustomTextStyles.thickb14,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: getTimelineUI(
                                testViewModel.testCalenderModel!.testData),
                          ),
                        ],
                      ),
                    ),
        );
      });
    });
  }

  Widget getTimelineUI(List<TestData> testData) {
    Widget contents(index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: CustomTextField(
                text: testData[index].testpaperTitle,
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
      itemCount: testData.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          courseDates[index] = (DateTime.parse(
                  testViewModel.testCalenderModel!.testData.first.created)
              .add(Duration(
                  days: testViewModel
                      .testCalenderModel!.testData[index].days)));
        } else {
          courseDates[index] = (courseDates[index - 1].add(Duration(
              days: testViewModel.testCalenderModel!.testData[index].days)));
        }
        return Padding(
          padding: EdgeInsets.only(
              bottom: index == testData.length - 1 ? 0 : 20),
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

  List<TestTypeList> testTypeList = [
    TestTypeList(name: "Full Scale Test", id: 4),
    TestTypeList(name: "Sectional Test", id: 5),
    TestTypeList(name: "Chapter papers", id: 6),
  ];

}

class TestTypeList {
  String name;
  int id;
  TestTypeList({required this.name, required this.id});
}
