import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:flutter_architecture/common/widgets/AppBarQuestionsView.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/main.dart';
import 'package:flutter_architecture/modules/test/model/test_questions_model.dart';
import 'package:flutter_architecture/modules/test/view/test_detail_view.dart';
import 'package:flutter_architecture/modules/test/view_model/test_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TestQuestionView extends StatefulWidget {
  @override
  TestQuestionViewState createState() => TestQuestionViewState();
}

class TestQuestionViewState extends State<TestQuestionView> {
  late TestViewModel testViewModel;
  String? quesName;
  int? bookmarkId;

  int? testId;
  int questionIndex = -1;
  int selectedAnswer = -1;
  int totalOptions = 2;

  /// All question groups for the currently-loaded test, or empty if not yet
  /// fetched.
  List<QuestionsListModel> get _qList =>
      testViewModel.testQuestionsList?.questionModelList ?? const [];

  /// The single question we render on the current page. Null when the test
  /// data hasn't loaded yet, the index is out of range, or the API returned a
  /// parent group with an empty `questions` array.
  QuestionModel? get _currentQuestion {
    if (questionIndex < 1 || questionIndex > _qList.length) return null;
    final group = _qList[questionIndex - 1];
    if (group.questions.isEmpty) return null;
    return group.questions[0];
  }

  @override
  void initState() {
    testViewModel = Provider.of<TestViewModel>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments == null || arguments is! TestParams) return;

    testId = arguments.testId;
    questionIndex = arguments.questionNo;

    // The API can return parent question records whose inner `questions` list
    // is empty. Skip past those so we never index `[0]` into an empty list.
    while (questionIndex >= 1 &&
        questionIndex <= _qList.length &&
        _qList[questionIndex - 1].questions.isEmpty) {
      questionIndex++;
    }

    if (questionIndex < 1 || questionIndex > _qList.length) {
      // Test had no usable questions, or the user already advanced past the
      // last one. Bail out instead of rendering a broken screen.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Fluttertoast.showToast(msg: "This test has no questions.");
        if (Navigator.canPop(context)) Navigator.of(context).pop();
      });
      return;
    }

    final q = _currentQuestion!;

    // Bookmark fetch may have errored upstream, leaving the list null. Treat
    // that as "no bookmarks" rather than crashing.
    final bookmarks =
        testViewModel.bookmarkQuestionList?.bookmarkQuestionItems ?? const [];
    final match = bookmarks.where((e) => e.id == q.id);
    bookmarkId = match.isNotEmpty ? match.first.bookmarkId : null;

    await testViewModel.saveUserTestPaperSessions(
      testPaperId: testId!,
      questionCode: q.queCode,
      eventName: TestEvents.QUESTION_STARTED,
      subjectId: q.subjectId,
      isCorrect: null,
      extraData: {},
    );

    totalOptions = 2;
    if (q.option3.isNotEmpty) {
      totalOptions++;
      if (q.option4.isNotEmpty) {
        totalOptions++;
        if (q.option5.isNotEmpty) {
          totalOptions++;
        }
      }
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TestViewModel>(
      builder: (context, viewmodel, child) {
        final q = _currentQuestion;
        return WillPopScope(
          onWillPop: () async {
            _showExitBottomSheet(context);
            return false;
          },
          child: (questionIndex == -1 || q == null)
              ? Scaffold(
                  body: Center(
                    child: CustomTextField(text: "Question not found"),
                  ),
                )
              : Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBarQuestionsView(
                      progress: (questionIndex - 1) / _qList.length,
                      onOverviewPressed: () =>
                          _openOverviewBottomSheet(context),
                      onEndTestPressed: () => _showExitBottomSheet(context)),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: AppColors.grey,
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  child: CustomTextField(
                                    text: NumberFormat('00')
                                        .format(questionIndex)
                                        .toString(),
                                    styleFace: CustomTextStyles.thickb14,
                                  )),
                              Row(
                                children: [
                                  CustomTextField(
                                    text: "03:26",
                                    styleFace: CustomTextStyles.b14.primary,
                                  ),
                                  SizedBox(width: 20),
                                  InkWell(
                                      onTap: () async {
                                        if (bookmarkId != null) {
                                          int? tempId = bookmarkId;
                                          bookmarkId = null;
                                          setState(() {});
                                          bool isAdded = await testViewModel
                                              .removeBookmarkQuestion(
                                                  id: tempId!,
                                                  questionId:
                                                      q.id.toString());
                                          await testViewModel
                                              .getBookmarkQuestionList();
                                          setState(() {});
                                          if (!isAdded) {
                                            bookmarkId = tempId;
                                            setState(() {});
                                          }
                                        } else {
                                          bookmarkId = 0;
                                          setState(() {});
                                          bool isAdded = await testViewModel
                                              .addBookmarkQuestion(
                                                  questionId: q.id);
                                          await testViewModel
                                              .getBookmarkQuestionList();
                                          setState(() {});
                                          if (!isAdded) {
                                            bookmarkId = null;
                                            setState(() {});
                                          }
                                        }
                                      },
                                      child: Icon(
                                        bookmarkId != null
                                            ? Icons.bookmark
                                            : Icons.bookmark_border,
                                      ))
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          if (q.groupQueDirections.isNotEmpty) ...[
                            ExpansionTile(
                              title: CustomTextField(
                                text: "Directions",
                                styleFace: CustomTextStyles.b14,
                                align: TextAlign.left,
                              ),
                              children: [
                                CustomTextField(
                                  text: q.groupQueDirections,
                                  styleFace: CustomTextStyles.r14,
                                ),
                              ],
                            ),
                          ],
                          if (q.questionType ==
                              QuestionType.COMPREHENSION) ...[
                            ExpansionTile(
                              title: CustomTextField(
                                text: "Passage",
                                styleFace: CustomTextStyles.b14,
                                align: TextAlign.left,
                              ),
                              children: [
                                Container(
                                  height: 200,
                                  child: SingleChildScrollView(
                                    child: CustomTextField(
                                      text: q.groupQueText,
                                      styleFace: CustomTextStyles.r14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                          Container(
                              child: CustomTextField(
                            text: q.questionTitle,
                            styleFace: CustomTextStyles.thickb14,
                          )),
                          SizedBox(height: 20),
                          for (int i = 1; i <= totalOptions; i++) ...[
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  selectedAnswer = i;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: selectedAnswer == i ? 1.5 : 1,
                                      color: selectedAnswer == i
                                          ? AppColors.primary
                                          : AppColors.grey),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 30,
                                        height: 30,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: AppColors.grey,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                            child: CustomTextField(
                                          text: i == 1
                                              ? "A"
                                              : i == 2
                                                  ? "B"
                                                  : i == 3
                                                      ? "C"
                                                      : i == 4
                                                          ? "D"
                                                          : "E",
                                          styleFace:
                                              CustomTextStyles.thickb14,
                                        ))),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: CustomTextField(
                                        text: i == 1
                                            ? q.option1
                                            : i == 2
                                                ? q.option2
                                                : i == 3
                                                    ? q.option3
                                                    : i == 4
                                                        ? q.option4
                                                        : q.option5,
                                        styleFace: CustomTextStyles.b14,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (_qList.length > questionIndex)
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                      child: ElevatedButton(
                                    onPressed: () async {
                                      testViewModel.testAnswers
                                          .add({questionIndex: -1});
                                      await testViewModel
                                          .saveUserTestPaperSessions(
                                        testPaperId: testId!,
                                        questionCode: q.queCode,
                                        subjectId: q.subjectId,
                                        isCorrect: null,
                                        eventName:
                                            TestEvents.QUESTION_SKIPPED,
                                        extraData: {},
                                      );
                                      Navigator.pushReplacementNamed(
                                          context, AppRoutes.test_question,
                                          arguments: TestParams(
                                              testId: testId!,
                                              questionNo:
                                                  questionIndex + 1));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.white,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: AppColors.primary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                    child: CustomTextField(
                                      text: "Skip",
                                      upperCase: false,
                                      color: AppColors.white,
                                      styleFace:
                                          CustomTextStyles.r15.primary,
                                    ),
                                  )),
                                ),
                              SizedBox(width: 12),
                              if (selectedAnswer != -1 ||
                                  _qList.length == questionIndex)
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                      child: ElevatedButton(
                                    onPressed: () async {
                                      testViewModel.testAnswers.add(
                                          {questionIndex: selectedAnswer});
                                      if (_qList.length > questionIndex) {
                                        await testViewModel
                                            .saveUserTestPaperSessions(
                                          testPaperId: testId!,
                                          questionCode: q.queCode,
                                          subjectId: q.subjectId,
                                          isCorrect: q.answer ==
                                              selectedAnswer.toString(),
                                          eventName:
                                              TestEvents.QUESTION_ANSWERED,
                                          extraData: {
                                            'option':
                                                selectedAnswer.toString(),
                                          },
                                        );
                                        Navigator.pushReplacementNamed(
                                            context, AppRoutes.test_question,
                                            arguments: TestParams(
                                                testId: testId!,
                                                questionNo:
                                                    questionIndex + 1));
                                      } else {
                                        await testViewModel
                                            .saveUserTestPaperSessions(
                                          testPaperId: testId!,
                                          questionCode: q.queCode,
                                          subjectId: q.subjectId,
                                          isCorrect: q.answer ==
                                              selectedAnswer.toString(),
                                          eventName:
                                              TestEvents.QUESTION_ANSWERED,
                                          extraData: {
                                            'option':
                                                selectedAnswer.toString(),
                                          },
                                        );
                                        await testViewModel
                                            .saveUserTestPaperSessions(
                                          testPaperId: testId!,
                                          questionCode: q.queCode,
                                          subjectId: null,
                                          isCorrect: null,
                                          eventName:
                                              TestEvents.TEST_COMPLETED,
                                          extraData: {},
                                        );
                                        Navigator.pushReplacementNamed(
                                            context, AppRoutes.test_result,
                                            arguments: testId!);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: AppColors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: AppColors.primary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ),
                                    child: CustomTextField(
                                      text: _qList.length > questionIndex
                                          ? "Next"
                                          : "Submit",
                                      upperCase: false,
                                      color: AppColors.white,
                                      styleFace:
                                          CustomTextStyles.r15.white,
                                    ),
                                  )),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  void _openOverviewBottomSheet(context) async {
    await testViewModel.saveUserTestPaperSessions(
        testPaperId: testId!,
        questionCode: null,
        subjectId: null,
        isCorrect: null,
        eventName: TestEvents.SUMMARY_OPENED,
        extraData: {});
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                      child: CustomTextField(
                        text: "Overview",
                        styleFace: CustomTextStyles.b18,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                    child: Row(
                      children: [
                        Container(
                            child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                Icons.check_box,
                                color: AppColors.white,
                                size: 15,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  text: (testViewModel.testAnswers.length -
                                          testViewModel.testAnswers
                                              .where((element) =>
                                                  element[questionIndex] == -1)
                                              .length)
                                      .toString(),
                                  styleFace: CustomTextStyles.thickb14,
                                ),
                                CustomTextField(
                                  text: "ANSWERED",
                                  styleFace: CustomTextStyles.r12.darkGrey,
                                ),
                              ],
                            ),
                          ],
                        )),
                        SizedBox(
                          width: 50,
                        ),
                        Container(
                            child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                Icons.question_mark,
                                color: AppColors.white,
                                size: 15,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  text: (_qList.length -
                                          testViewModel.testAnswers.length +
                                          testViewModel.testAnswers
                                              .where((element) =>
                                                  element[questionIndex] == -1)
                                              .length)
                                      .toString(),
                                  styleFace: CustomTextStyles.thickb14,
                                ),
                                CustomTextField(
                                  text: "UNANSWERED",
                                  styleFace: CustomTextStyles.r12.darkGrey,
                                ),
                              ],
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  color: AppColors.primary),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            CustomTextField(
                              text: "Quantitative Analysis",
                              styleFace: CustomTextStyles.r14,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: AppColors.grey,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: List.generate(
                              20,
                              (index) {
                                return Container(
                                  width: 30.0,
                                  height: 30.0,
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: CustomTextField(
                                      text: (index + 1).toString(),
                                      styleFace: CustomTextStyles.b12,
                                    ),
                                  ),
                                );
                              },
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  color: AppColors.primary),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            CustomTextField(
                              text: "Quantitative Analysis",
                              styleFace: CustomTextStyles.r14,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: AppColors.grey,
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: List.generate(
                              20,
                              (index) {
                                return Container(
                                  width: 30.0,
                                  height: 30.0,
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: CustomTextField(
                                      text: (index + 1).toString(),
                                      styleFace: CustomTextStyles.b12,
                                    ),
                                  ),
                                );
                              },
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showExitBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16),
              Text(
                'Are you sure you want to end test ?',
                style: CustomTextStyles.b18,
              ),
              SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(15)),
                            child: Icon(
                              Icons.check_box,
                              color: AppColors.white,
                              size: 15,
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                text: (questionIndex - 1).toString(),
                                styleFace: CustomTextStyles.thickb14,
                              ),
                              CustomTextField(
                                text: "ANSWERED",
                                styleFace: CustomTextStyles.r12.darkGrey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(15)),
                            child: Icon(
                              Icons.question_mark,
                              color: AppColors.white,
                              size: 15,
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                text:
                                    (_qList.length + 1 - questionIndex)
                                        .toString(),
                                styleFace: CustomTextStyles.thickb14,
                              ),
                              CustomTextField(
                                text: "UNANSWERED",
                                styleFace: CustomTextStyles.r12.darkGrey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: AppColors.primary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: CustomTextField(
                          text: "Go back",
                          upperCase: false,
                          styleFace: CustomTextStyles.r14.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await testViewModel.saveUserTestPaperSessions(
                            testPaperId: testId!,
                            questionCode: null,
                            subjectId: null,
                            isCorrect: null,
                            eventName: TestEvents.TEST_QUIT,
                            extraData: {});
                        testViewModel.testAnswers = [];
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                            navigatorKey.currentContext!, AppRoutes.test_list);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: CustomTextField(
                          text: "End Test",
                          upperCase: false,
                          styleFace: CustomTextStyles.r14.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  getQuestions() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              (index + 1).toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
