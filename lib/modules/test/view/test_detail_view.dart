import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/common/widgets/custom_button.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/test/view_model/test_view_model.dart';
import 'package:provider/provider.dart';

class TestDetailView extends StatefulWidget {
  @override
  TestDetailViewState createState() => TestDetailViewState();
}

class TestDetailViewState extends State<TestDetailView> {
  late TestViewModel testViewModel;

  @override
  void initState() {
    testViewModel = Provider.of<TestViewModel>(context, listen: false);
    super.initState();
  }

  String? testName;
  int? testId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null && arguments is int) {
      testId = arguments;
      testViewModel.testCalenderModel!.testData.forEach((element) {
        if (element.id == testId) {
          testName = element.testpaperTitle;
        }
      });
      if (testName != null) {
        testViewModel.getTestDetail(keyword: null, testId: testId!);
        testViewModel.getTestPaperQuestionList(keyword: null, testId: testId!);
        testViewModel.getBookmarkQuestionList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TestViewModel>(
      builder: (context, viewmodel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarViewV2(title: testName ?? "Test name"),
          bottomNavigationBar: testViewModel.testDetailLoadingStatus ||
                  testViewModel.testQuestionsLoadingStatus ||
                  testViewModel.bookmarkListLoadingStatus
              ? null
              : Container(
                  margin: EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height * 0.0625,
                  child: CustomButton(
                      text: "Start Test",
                      onPressed: () async {
                        testViewModel.createSessionId();

                        await testViewModel.saveUserTestPaperSessions(
                            testPaperId: testId!,
                            questionCode: null,
                            subjectId: null,
                            isCorrect: null,
                            eventName: TestEvents.TEST_STARTED,
                            extraData: {});
                        // pushReplacementNamed (not pushNamedAndRemoveUntil
                        // with `(_) => false`) — we want the test list / home
                        // to remain in the stack so the user can navigate back
                        // after completing or quitting the test.
                        Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.test_question,
                            arguments:
                                TestParams(testId: testId!, questionNo: 1));
                      }),
                ),
          body: testViewModel.testDetailLoadingStatus ||
                  testViewModel.testQuestionsLoadingStatus
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : Builder(builder: (context) {
                  // The API returns questions grouped under `QuestionsListModel`
                  // entries (each group can hold one or more `QuestionModel`s,
                  // e.g. a comprehension passage). The user-facing question
                  // count must sum the inner questions, not just count groups.
                  final totalQuestions = testViewModel
                      .testQuestionsList!.questionModelList
                      .fold<int>(0, (sum, g) => sum + g.questions.length);
                  return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.chat_bubble_outlined,
                                  color: AppColors.black,
                                ),
                                SizedBox(width: 10),
                                CustomTextField(
                                    text: "$totalQuestions Questions"),
                              ],
                            ),
                            SizedBox(width: 50),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_filled,
                                  color: AppColors.black,
                                ),
                                SizedBox(width: 10),
                                CustomTextField(
                                    text:
                                        "${testViewModel.testDetail!.testItem[0].totalTime} Minutes"),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          text: "Instructions",
                          styleFace: CustomTextStyles.thickb14,
                        ),
                        SizedBox(height: 20),
                        Container(
                          // height: MediaQuery.of(context).size.height * .6,
                          child: CustomTextField(
                            text: testViewModel
                                .testDetail!.testItem[0].testpaperInstructions,
                            styleFace: CustomTextStyles.r12,
                          ),
                        )
                      ],
                    ),
                  ),
                );
                }),
        );
      },
    );
  }
}

class TestParams {
  final int testId;
  final int questionNo;

  TestParams({required this.testId, required this.questionNo});
}
