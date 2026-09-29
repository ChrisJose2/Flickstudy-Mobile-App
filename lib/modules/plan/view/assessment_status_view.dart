import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/study/models/subject_model.dart';
import 'package:flutter_architecture/modules/study/models/subject_session_model.dart';
import 'package:flutter_architecture/modules/study/view_models/study_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AssessmentStatusView extends StatefulWidget {
  AssessmentStatusView({Key? key}) : super(key: key);

  @override
  State<AssessmentStatusView> createState() => _AssessmentStatusViewState();
}

class _AssessmentStatusViewState extends State<AssessmentStatusView> {
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
      await Future.wait([
        studyViewModel.getSubjectChapters(
            courseId: studyViewModel.userPackage!.packageList[0].courses[0].id,
            subjectId: studyViewModel.courseSubjects!.subjectList[0].id),
        studyViewModel.getUserChapterSessionsList(
            studyViewModel.courseSubjects!.subjectList[0].id),
      ]);
      chooseSubjects();
      studyViewModel.userChapterSessionsLoadingStatus = false;
      studyViewModel.notifyListeners();
      selectedSubjectIndex = 0;
    }
  }

  List<SubjectSessionItem> selectedSubject = [];

  chooseSubjects() {
    for (int i = 0;
        i < studyViewModel.subjectChapters!.chapterList.length;
        i++) {
      if (studyViewModel.subjectChapters!.chapterList[i].type == "chapter") {
        for (int j = 0;
            j < studyViewModel.userChapterSessions!.sessionItemList.length;
            j++) {
          if (studyViewModel.subjectChapters!.chapterList[i].id ==
              studyViewModel
                  .userChapterSessions!.sessionItemList[j].chapterId) {
            selectedSubject
                .add(studyViewModel.userChapterSessions!.sessionItemList[j]);
          } else {
            selectedSubject.add(SubjectSessionItem(
              chapterId: studyViewModel.subjectChapters!.chapterList[i].id,
              chapterName:
                  studyViewModel.subjectChapters!.chapterList[i].chapterTitle,
              subjectId:
                  studyViewModel.subjectChapters!.chapterList[i].subjectId,
              percentageCompletion: 0,
              timeSpent: 0,
            ));
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarViewV2(title: "Assessment Status"),
        body: studyViewModel.subjectsLoadingStatus ||
                studyViewModel.userChapterSessionsLoadingStatus
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _openSubjectBottomSheet(context,
                                studyViewModel.courseSubjects!.subjectList);
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
                                  text: studyViewModel
                                      .courseSubjects!
                                      .subjectList[selectedSubjectIndex]
                                      .subjectTitle,
                                  styleFace: CustomTextStyles.thickb14,
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(height: 20),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Icon(Icons.flag),
                        //     SizedBox(
                        //       width: 20,
                        //     ),
                        //     CustomTextField(
                        //       text:
                        //           "Started on ${DateFormat("dd MMM’yy").format(DateTime.parse(studyViewModel.userPackage!.packageList.first.created))}",
                        //       styleFace: CustomTextStyles.thickb14,
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: selectedSubject.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.zero,
                                    leading: CustomTextField(
                                      text: NumberFormat('00')
                                          .format(index + 1)
                                          .toString(),
                                      styleFace:
                                          CustomTextStyles.thickb22.darkGrey,
                                    ),
                                    title: Container(
                                        margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                        child: CustomTextField(
                                            text: selectedSubject[index]
                                                .chapterName,
                                            styleFace: CustomTextStyles.b12)),
                                    subtitle: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: Column(
                                          children: [
                                            LinearProgressIndicator(
                                              value: selectedSubject[index]
                                                      .percentageCompletion /
                                                  100,
                                              color: AppColors.primary,
                                              backgroundColor: AppColors.grey,
                                              // valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary), // Optional: Set progress color
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                CustomTextField(
                                                    text:
                                                        '${selectedSubject[index].percentageCompletion}%',
                                                    styleFace: CustomTextStyles
                                                        .r12.primary),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                CustomTextField(
                                                    text: selectedSubject[index]
                                                            .timeSpent
                                                            .toString() +
                                                        " seconds spent",
                                                    styleFace: CustomTextStyles
                                                        .b12.darkGrey),
                                              ],
                                            ),
                                          ],
                                        )),
                                    // trailing: Icon(
                                    //   Icons.arrow_forward_rounded,
                                    //   size: 18,
                                    //   color: AppColors.darkGrey,
                                    // ),
                                    // onTap: () {
                                    //   // Navigator.pushNamed(
                                    //   //     context, AppRoutes.watchOutDetail);
                                    // },
                                  ),
                                  // if (index != 9) Divider(),
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
  }

  void _openSubjectBottomSheet(context, List<Subject> subjectList) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
            decoration: BoxDecoration(
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
                for (int i = 0; i < subjectList.length; i++)
                  if (subjectList[i].type == "subject")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            selectedSubjectIndex = i;
                            selectedSubject = [];
                            setState(() {});
                            Navigator.pop(context);
                            await Future.wait([
                              studyViewModel.getSubjectChapters(
                                  courseId: studyViewModel.userPackage!
                                      .packageList[0].courses[0].id,
                                  subjectId: subjectList[i].id),
                              studyViewModel.getUserChapterSessionsList(
                                  studyViewModel
                                      .courseSubjects!.subjectList[0].id),
                            ]);
                            chooseSubjects();
                            studyViewModel.userChapterSessionsLoadingStatus =
                                false;
                            studyViewModel.notifyListeners();
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextField(
                                        text: subjectList[i].subjectTitle,
                                        styleFace: CustomTextStyles.r14),
                                  ],
                                ),
                              ),
                              i == selectedSubjectIndex
                                  ? Container(
                                      height: 42,
                                      width: 36,
                                      child: Icon(Icons.check_circle))
                                  : Container(
                                      height: 42,
                                      width: 36,
                                    ),
                            ],
                          ),
                        ),
                        if (i != subjectList.length - 1) ...[
                          Divider(),
                          SizedBox(
                            height: 4,
                          ),
                        ],
                      ],
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
