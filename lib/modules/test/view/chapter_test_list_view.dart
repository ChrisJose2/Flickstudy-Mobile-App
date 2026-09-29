import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/modules/study/view_models/study_view_model.dart';
import 'package:flutter_architecture/modules/test/model/test_calender_model.dart';
import 'package:flutter_architecture/modules/test/view_model/test_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/styles/custom_text_styles.dart';
import '../../../common/widgets/text_widget.dart';

class ChapterTestListView extends StatefulWidget {
  ChapterTestListView({Key? key}) : super(key: key);

  @override
  State<ChapterTestListView> createState() => _ChapterTestListViewState();
}

class _ChapterTestListViewState extends State<ChapterTestListView> {
  bool allSelected = true;

  late StudyViewModel studyViewModel;
  late TestViewModel testViewModel;

  @override
  void initState() {
    studyViewModel = Provider.of<StudyViewModel>(context, listen: false);
    testViewModel = Provider.of<TestViewModel>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      testViewModel.getTestCalenderList(
          courseId: studyViewModel.userPackage!.packageList[0].courses[0].id,
          subjectId: null,
          type: null);
      studyViewModel.getCourseSubjects();
    });
    super.initState();
  }

  int selectedSubjectId = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyViewModel>(builder: (context, viewmodel1, child) {
      return Consumer<TestViewModel>(builder: (context, viewmodel2, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarViewV2(title: "Chapter Test"),
          body: testViewModel.testCalenderLoadingStatus ||
                  studyViewModel.subjectsLoadingStatus
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                allSelected = true;
                              });
                            },
                            child: Column(
                              children: [
                                CustomTextField(
                                  text: "All",
                                  styleFace: CustomTextStyles.thickb14,
                                ),
                                SizedBox(height: 5),
                                if (allSelected)
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 2,
                                    color: AppColors.primary,
                                  )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                allSelected = false;
                              });
                            },
                            child: Column(
                              children: [
                                CustomTextField(
                                    text: "Completed",
                                    styleFace: CustomTextStyles.thickb14),
                                SizedBox(height: 5),
                                if (!allSelected)
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 2,
                                    color: AppColors.primary,
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _openSubjectBottomSheet(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomTextField(
                                text: selectedSubjectId == -1
                                    ? "All"
                                    : studyViewModel.courseSubjects!.subjectList
                                        .firstWhere((element) =>
                                            element.id == selectedSubjectId)
                                        .subjectTitle,
                                styleFace: CustomTextStyles.thickb14,
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              testViewModel.testCalenderModel!.testData.length,
                          itemBuilder: (context, index) {
                            TestData testData = testViewModel
                                .testCalenderModel!.testData[index];
                            return Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                      padding: EdgeInsets.all(10),
                                      child: CustomTextField(
                                        text: NumberFormat('00')
                                            .format(index + 1)
                                            .toString(),
                                        styleFace:
                                            CustomTextStyles.thickb22.darkGrey,
                                      )),
                                  title: Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: CustomTextField(
                                          text: testData.testpaperTitle,
                                          styleFace: CustomTextStyles.b12)),
                                  subtitle: Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Column(
                                      children: [
                                        LinearProgressIndicator(
                                          value: 0.5,
                                          backgroundColor: AppColors.grey,
                                          // valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary), // Optional: Set progress color
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            CustomTextField(
                                                text: '57%',
                                                styleFace: CustomTextStyles
                                                    .r12.primary),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            CustomTextField(
                                                text:
                                                    "${testData.totalTime} mins",
                                                styleFace: CustomTextStyles
                                                    .b12.darkGrey),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 18,
                                    color: AppColors.darkGrey,
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.test_detail,
                                        arguments: testData.id);
                                  },
                                ),
                                if (index != 9) Divider(),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
        );
      });
    });
  }

  void _openSubjectBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  //could change this to Color(0xFF737373),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextField(
                    text: "Subjects",
                    styleFace: CustomTextStyles.thickb14,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedSubjectId = -1;
                                  });
                                  testViewModel.getTestCalenderList(
                                      courseId: studyViewModel.userPackage!
                                          .packageList[0].courses[0].id,
                                      subjectId: null,
                                      type: null);
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        text: "All",
                                        styleFace: CustomTextStyles.r14,
                                      ),
                                    ),
                                    if (selectedSubjectId == -1)
                                      Icon(
                                        Icons.check,
                                        size: 18,
                                      )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Divider(),
                            ],
                          ),
                          for (int i = 0;
                              i <
                                  studyViewModel
                                      .courseSubjects!.subjectList.length;
                              i++)
                            studyViewModel
                                        .courseSubjects!.subjectList[i].type ==
                                    "image"
                                ? Container()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        dense: true,
                                        title: CustomTextField(
                                            text: studyViewModel.courseSubjects!
                                                .subjectList[i].subjectTitle,
                                            styleFace: CustomTextStyles.r14),
                                        trailing: selectedSubjectId ==
                                                studyViewModel.courseSubjects!
                                                    .subjectList[i].id
                                            ? Icon(
                                                Icons.check,
                                                size: 18,
                                              )
                                            : null,
                                        contentPadding: EdgeInsets.zero,
                                        onTap: () {
                                          setState(() {
                                            selectedSubjectId = studyViewModel
                                                .courseSubjects!
                                                .subjectList[i]
                                                .id;
                                          });
                                          testViewModel.getTestCalenderList(
                                              courseId: studyViewModel
                                                  .userPackage!
                                                  .packageList[0]
                                                  .courses[0]
                                                  .id,
                                              subjectId: selectedSubjectId,
                                              type: null);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      if (i !=
                                          studyViewModel.courseSubjects!
                                                  .subjectList.length -
                                              1)
                                        Divider(),
                                    ],
                                  ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}
