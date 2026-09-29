import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:flutter_architecture/common/widgets/app_bar.dart';
import 'package:flutter_architecture/common/widgets/bar_chart.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/test/view_model/test_view_model.dart';
import 'package:provider/provider.dart';

class TestAnalysisView extends StatefulWidget {
  @override
  TestAnalysisViewState createState() => TestAnalysisViewState();
}

class TestAnalysisViewState extends State<TestAnalysisView> {
  String selectedType = AppConstants.TEST_ANALYSIS;
  int selectedIndex = 0;
  int selectedSubIndex = 0;
  double _startX = 0.0;
  double _currentX = 0.0;
  List<String> items = [
    "Results",
    "Section",
    "Run-rate",
    "Flow",
    "Complexity",
    "Compare"
  ];
  List<String> sectionLabels = [
    "Questions Answered",
    "% Questions Answered",
    "Time Spent on section (in mins)",
    "Time per Question (seconds)",
    "Answered Correct",
    "Answered Incorrect",
    "% Accuracy",
    "Marks"
  ];
  int selectedTestIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<TestViewModel>(builder: (context, viewmodel, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarView(),
          body: testViewModel.testSessionList.length == 0 ||
                  testViewModel.testResult == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _openTestBottomSheet(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextField(
                              text: testViewModel
                                  .testSessionList[selectedTestIndex]
                                  .testpaper_title,
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (int i = 0; i < items.length; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = i;
                                  selectedSubIndex = 0;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      text: items[i],
                                      styleFace: selectedIndex == i
                                          ? CustomTextStyles.thickb14
                                          : CustomTextStyles.r14,
                                    ),
                                    selectedIndex == i
                                        ? SizedBox(
                                            height: 5,
                                          )
                                        : Container(),
                                    selectedIndex == i
                                        ? Container(
                                            width: 70,
                                            height: 2,
                                            color: AppColors.primary,
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    selectWidget(),
                  ],
                ));
    });
  }

  Widget selectWidget() {
    if (selectedIndex == 0) {
      return getTestResultWidget();
    }
    if (selectedIndex == 1) {
      Map<String, List<Map<String, dynamic>>> xyBar = {};
      xyBar['accuracy'] = [];
      xyBar['answered_questions'] = [];
      xyBar['avg_time_spent_per_question'] = [];
      xyBar['correct_answers'] = [];
      xyBar['incorrect_answers'] = [];
      xyBar['marks_obtained'] = [];
      xyBar['percent_answered'] = [];
      xyBar['total_time_spent'] = [];

      //Convert the subject name and value to a hashmap
      for (var element in testViewModel.testResult!.subjects) {
        //add each element of accuracy to the key accuracy array

        xyBar['accuracy']
            ?.add({element.subject_name: element.section.accuracy});
        xyBar['answered_questions']
            ?.add({element.subject_name: element.section.answered_questions});
        xyBar['avg_time_spent_per_question']?.add({
          element.subject_name: element.section.avg_time_spent_per_question
        });
        xyBar['correct_answers']
            ?.add({element.subject_name: element.section.correct_answers});
        xyBar['incorrect_answers']
            ?.add({element.subject_name: element.section.incorrect_answers});
        xyBar['marks_obtained']
            ?.add({element.subject_name: element.section.marks_obtained});
        xyBar['percent_answered']
            ?.add({element.subject_name: element.section.percent_answered});

        xyBar['total_time_spent']
            ?.add({element.subject_name: element.section.total_time_spent});
      }

      return SingleChildScrollView(
        child: GestureDetector(
          onHorizontalDragStart: (details) {
            _startX = details.globalPosition.dx;
          },
          onHorizontalDragUpdate: (details) {
            _currentX = details.globalPosition.dx;
          },
          onHorizontalDragEnd: (details) {
            double deltaX = _currentX - _startX;

            // You can customize the threshold for considering it a swipe
            if (deltaX < 0.0) {
              // Swiped right
              setState(() {
                if (selectedSubIndex < sectionLabels.length - 1)
                  selectedSubIndex++;
                else
                  selectedSubIndex = 0;
              });
            } else {
              setState(() {
                if (selectedSubIndex > 0)
                  selectedSubIndex--;
                else
                  selectedSubIndex = sectionLabels.length - 1;
              });
            }
          },
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Column(
                    children: [
                      CustomTextField(
                        text: sectionLabels[selectedSubIndex],
                        styleFace: CustomTextStyles.b14.primary,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              BarChartSample3(
                data: getSelectedKeyName(xyBar) ??
                    [], //convert this list to list of string
              ),
              SizedBox(height: 50),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < sectionLabels.length; i++)
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          color: i == selectedSubIndex
                              ? AppColors.primary
                              : AppColors.grey,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }

  getSelectedKeyName(xyBar) {
    if (selectedSubIndex == 0) {
      return xyBar['answered_questions'];
    }
    if (selectedSubIndex == 1) {
      return xyBar['percent_answered'];
    }
    if (selectedSubIndex == 2) {
      return xyBar['total_time_spent'];
    }
    if (selectedSubIndex == 3) {
      return xyBar['avg_time_spent_per_question'];
    }

    if (selectedSubIndex == 4) {
      return xyBar['correct_answers'];
    }
    if (selectedSubIndex == 5) {
      return xyBar['incorrect_answers'];
    }
    if (selectedSubIndex == 6) {
      return xyBar['accuracy'];
    }
    if (selectedSubIndex == 7) {
      return xyBar['marks_obtained'];
    }
  }

  getTestResultWidget() {
    return SingleChildScrollView(
        child: GestureDetector(
      onHorizontalDragStart: (details) {
        _startX = details.globalPosition.dx;
      },
      onHorizontalDragUpdate: (details) {
        _currentX = details.globalPosition.dx;
      },
      onHorizontalDragEnd: (details) {
        double deltaX = _currentX - _startX;

        // You can customize the threshold for considering it a swipe
        if (deltaX < 0.0) {
          // Swiped right
          setState(() {
            if (selectedSubIndex <
                testViewModel.testResult!.subjects.length - 1)
              selectedSubIndex++;
            else
              selectedSubIndex = 0;
          });
        } else {
          setState(() {
            if (selectedSubIndex > 0)
              selectedSubIndex--;
            else
              selectedSubIndex = testViewModel.testResult!.subjects.length - 1;
          });
        }
      },
      child: Container(
          margin: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              child: Center(
                child: Column(
                  children: [
                    CustomTextField(
                      text: "Performance and Accuracy",
                      styleFace: CustomTextStyles.b14.primary,
                    ),
                    CustomTextField(
                      text: testViewModel
                          .testResult!.subjects[selectedSubIndex].subject_name,
                      styleFace: CustomTextStyles.b14.primary,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GridTile(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (index == 0) getMarksWidget(),
                          if (index == 1) getAttemptedQuestionsWidget(),
                          if (index == 2) getRankWidget(),
                          if (index == 3) getCorrectQuestionsWidget(),
                          if (index == 4) getIncorrectQuestionsWidget(),
                          if (index == 5) getUnattemptedQuestionsWidget(),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: 6,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: Icon(Icons.access_time_filled),
                        decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            text: testViewModel
                                .testResult!
                                .subjects[selectedSubIndex]
                                .testResultItemModel
                                .totalTimeTaken
                                .toStringAsFixed(2),
                            styleFace: CustomTextStyles.thickb12,
                          ),
                          SizedBox(height: 5),
                          CustomTextField(
                            text: "Time",
                            styleFace: CustomTextStyles.r12,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(width: 20),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: Icon(Icons.check),
                        decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            text: testViewModel
                                .testResult!
                                .subjects[selectedSubIndex]
                                .testResultItemModel
                                .accuracy
                                .toStringAsFixed(2),
                            styleFace: CustomTextStyles.thickb12,
                          ),
                          SizedBox(height: 5),
                          CustomTextField(
                            text: "Accuracy",
                            styleFace: CustomTextStyles.r12,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(width: 20),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: Icon(Icons.speed),
                        decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            text: testViewModel
                                .testResult!
                                .subjects[selectedSubIndex]
                                .testResultItemModel
                                .speedQuestionsPerMin
                                .toStringAsFixed(0),
                            styleFace: CustomTextStyles.thickb12,
                          ),
                          SizedBox(height: 5),
                          CustomTextField(
                            text: "Q/Min",
                            styleFace: CustomTextStyles.r12,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(width: 12),
                ],
              ),
            ),
            SizedBox(height: 50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0;
                    i < testViewModel.testResult!.subjects.length;
                    i++)
                  Container(
                    margin: EdgeInsets.all(20),
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        color: i == selectedSubIndex
                            ? AppColors.primary
                            : AppColors.grey,
                        borderRadius: BorderRadius.circular(100)),
                  ),
              ],
            ),
            /*BarChartSample3(),
                            BarChartSample4(),*/
          ])),
    ));
  }

  Widget getMarksWidget() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomTextField(
                  text: testViewModel.testResult!.subjects[selectedSubIndex]
                      .testResultItemModel.totalMarksObtained
                      .toString(),
                  styleFace: CustomTextStyles.r22.primary,
                ),
                CustomTextField(
                  text: " / ",
                  styleFace: CustomTextStyles.thickb12,
                ),
                CustomTextField(
                  text: testViewModel.testResult!.subjects[selectedSubIndex]
                      .testResultItemModel.totalMarks
                      .toString(),
                  styleFace: CustomTextStyles.thickb12,
                ),
              ],
            ),
            SizedBox(height: 5),
            CustomTextField(
              text: "Marks",
              styleFace: CustomTextStyles.r12,
            )
          ],
        )
      ],
    );
  }

  Widget getAttemptedQuestionsWidget() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomTextField(
                  text: testViewModel.testResult!.subjects[selectedSubIndex]
                      .testResultItemModel.attemptedQuestions
                      .toString(),
                  styleFace: CustomTextStyles.r22.primary,
                ),
                CustomTextField(
                  text: " / ",
                  styleFace: CustomTextStyles.thickb12,
                ),
                CustomTextField(
                  text: testViewModel.testResult!.subjects[selectedSubIndex]
                      .testResultItemModel.totalQuestions
                      .toString(),
                  styleFace: CustomTextStyles.thickb12,
                ),
              ],
            ),
            SizedBox(height: 5),
            CustomTextField(
              text: "Attempted",
              styleFace: CustomTextStyles.r12,
            )
          ],
        )
      ],
    );
  }

  Widget getRankWidget() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomTextField(
                  text: "1",
                  styleFace: CustomTextStyles.r22.primary,
                ),
                CustomTextField(
                  text: " / ",
                  styleFace: CustomTextStyles.thickb12,
                ),
                CustomTextField(
                  text: "1",
                  styleFace: CustomTextStyles.thickb12,
                ),
              ],
            ),
            SizedBox(height: 5),
            CustomTextField(
              text: "Rank",
              styleFace: CustomTextStyles.r12,
            )
          ],
        )
      ],
    );
  }

  Widget getCorrectQuestionsWidget() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomTextField(
                  text: testViewModel.testResult!.subjects[selectedSubIndex]
                      .testResultItemModel.correctQuestions
                      .toString(),
                  styleFace: CustomTextStyles.r22.primary,
                ),
                CustomTextField(
                  text: " / ",
                  styleFace: CustomTextStyles.thickb12,
                ),
                CustomTextField(
                  text: testViewModel.testResult!.subjects[selectedSubIndex]
                      .testResultItemModel.totalQuestions
                      .toString(),
                  styleFace: CustomTextStyles.thickb12,
                ),
              ],
            ),
            SizedBox(height: 5),
            CustomTextField(
              text: "Correct",
              styleFace: CustomTextStyles.r12,
            )
          ],
        )
      ],
    );
  }

  Widget getIncorrectQuestionsWidget() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomTextField(
                  text: testViewModel.testResult!.subjects[selectedSubIndex]
                      .testResultItemModel.incorrectQuestions
                      .toString(),
                  styleFace: CustomTextStyles.r22.primary,
                ),
                CustomTextField(
                  text: " / ",
                  styleFace: CustomTextStyles.thickb12,
                ),
                CustomTextField(
                  text: testViewModel.testResult!.subjects[selectedSubIndex]
                      .testResultItemModel.totalQuestions
                      .toString(),
                  styleFace: CustomTextStyles.thickb12,
                ),
              ],
            ),
            SizedBox(height: 5),
            CustomTextField(
              text: "Incorrect",
              styleFace: CustomTextStyles.r12,
            )
          ],
        )
      ],
    );
  }

  Widget getUnattemptedQuestionsWidget() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomTextField(
                  text: (testViewModel.testResult!.subjects[selectedSubIndex]
                              .testResultItemModel.totalQuestions -
                          testViewModel.testResult!.subjects[selectedSubIndex]
                              .testResultItemModel.attemptedQuestions)
                      .toString(),
                  styleFace: CustomTextStyles.r22.primary,
                ),
                CustomTextField(
                  text: " / ",
                  styleFace: CustomTextStyles.thickb12,
                ),
                CustomTextField(
                  text: testViewModel.testResult!.subjects[selectedSubIndex]
                      .testResultItemModel.totalQuestions
                      .toString(),
                  styleFace: CustomTextStyles.thickb12,
                ),
              ],
            ),
            SizedBox(height: 5),
            CustomTextField(
              text: "Unattempted",
              styleFace: CustomTextStyles.r12,
            )
          ],
        )
      ],
    );
  }

  void _openTestBottomSheet(context) {
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
                    text: "Tests",
                    styleFace: CustomTextStyles.thickb14,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextField(
                            text: "All",
                            styleFace: CustomTextStyles.r14,
                          ),
                          Icon(Icons.check)
                        ],
                      ),
                      Divider()
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: testViewModel.testSessionList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTestIndex = index;
                                testViewModel.sessionId = testViewModel
                                    .testSessionList[index].session_id;
                                testViewModel.getTestResultWithOverall();
                              });
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextField(
                                  text: testViewModel
                                      .testSessionList[index].testpaper_title,
                                  styleFace: CustomTextStyles.r14,
                                ),
                                Icon(Icons.check)
                              ],
                            ),
                          ),
                          Divider()
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  getCardWithIconText(String title, String image) {
    return Container(
      height: MediaQuery.of(context).size.width * .3,
      width: MediaQuery.of(context).size.width * .28,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(left: 5, bottom: 5),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            image,
            width: 25,
          ),
          SizedBox(
            height: 5,
          ),
          CustomTextField(
            text: title,
            styleFace: CustomTextStyles.thickb14,
            align: TextAlign.center,
          )
        ],
      ),
    );
  }

  navigateTab(String type) {
    selectedType = type;

    if (type == AppConstants.STUDY) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.study, (Route<dynamic> route) => false);
    }
    if (type == AppConstants.TEST) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.test, (Route<dynamic> route) => false);
    }
    if (type == AppConstants.TEST_ANALYSIS) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.test_analysis, (Route<dynamic> route) => false);
    }
  }

  TestViewModel testViewModel = TestViewModel();
  @override
  void initState() {
    super.initState();
    testViewModel = Provider.of<TestViewModel>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      testViewModel.getTestSessionList().then((value) {
        testViewModel.sessionId = testViewModel.testSessionList[0].session_id;
        testViewModel.getTestResultWithOverall();
      });
    });
  }

  @override
  void dispose() {
    // _animationController.dispose();
    // _timer.cancel();
    super.dispose();
  }
}
