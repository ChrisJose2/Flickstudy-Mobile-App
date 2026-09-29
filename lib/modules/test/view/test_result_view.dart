import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/custom_button.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/test/view_model/test_view_model.dart';
import 'package:provider/provider.dart';

class TestResultView extends StatefulWidget {
  @override
  TestResultViewState createState() => TestResultViewState();
}

class TestResultViewState extends State<TestResultView> {
  late TestViewModel testViewModel;

  @override
  void initState() {
    testViewModel = Provider.of<TestViewModel>(context, listen: false);
    Timer(Duration(seconds: 5), () {
      testViewModel.testResult = null;
      testViewModel.getTestResult();
    });
    super.initState();
  }

  String? testName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null && arguments is int) {
      testViewModel.testCalenderModel!.testData.forEach((element) {
        if (element.id == arguments) {
          testName = element.testpaperTitle;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TestViewModel>(
      builder: (context, viewmodel, child) {
        return WillPopScope(
          onWillPop: () async {
            testViewModel.testAnswers = [];
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.home, (Route<dynamic> route) => false);
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: CustomTextField(
                  text: "Results", styleFace: CustomTextStyles.b16),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  testViewModel.testAnswers = [];
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.home, (Route<dynamic> route) => false);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            body: testViewModel.testResult == null
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    text: testName ?? "Test name",
                                    styleFace: CustomTextStyles.r24,
                                    align: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.messenger_sharp,
                                  color: AppColors.black,
                                ),
                                SizedBox(width: 8),
                                CustomTextField(
                                    text:
                                        "${testViewModel.testResult!.testResultItemModel.totalQuestions} Questions"),
                                SizedBox(width: 12),
                                Icon(
                                  Icons.access_time_filled,
                                  color: AppColors.black,
                                ),
                                SizedBox(width: 8),
                                CustomTextField(
                                    text:
                                        "${testViewModel.testResult!.testResultItemModel.totalTimeTaken.toStringAsFixed(2)} Minutes"),
                              ],
                            ),
                            SizedBox(height: 24),
                            CustomButton(
                                text: "View solution",
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.test_solution);
                                }),
                            SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: testViewModel
                                            .testResult!
                                            .testResultItemModel
                                            .correctQuestions
                                            .toString(),
                                        style: CustomTextStyles.b24.green,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  '/${testViewModel.testResult!.testResultItemModel.totalQuestions.toString()}',
                                              style: CustomTextStyles
                                                  .b12.darkGrey),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    CustomTextField(
                                      text: "Correct",
                                      styleFace: CustomTextStyles.r14,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: testViewModel
                                            .testResult!
                                            .testResultItemModel
                                            .incorrectQuestions
                                            .toString()
                                            .toString(),
                                        style: CustomTextStyles.b24.red,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  '/${testViewModel.testResult!.testResultItemModel.totalQuestions.toString()}',
                                              style: CustomTextStyles
                                                  .b12.darkGrey),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    CustomTextField(
                                      text: "Incorrect",
                                      styleFace: CustomTextStyles.r14,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: (testViewModel
                                                    .testResult!
                                                    .testResultItemModel
                                                    .totalQuestions -
                                                (testViewModel
                                                        .testResult!
                                                        .testResultItemModel
                                                        .correctQuestions +
                                                    testViewModel
                                                        .testResult!
                                                        .testResultItemModel
                                                        .incorrectQuestions))
                                            .toString(),
                                        style: CustomTextStyles.b24,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  '/${testViewModel.testQuestionsList!.questionModelList.length}',
                                              style: CustomTextStyles
                                                  .b12.darkGrey),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    CustomTextField(
                                      text: "Unanswered",
                                      styleFace: CustomTextStyles.r14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 32),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: CustomTextField(
                                text: "Detailed analysis",
                                styleFace: CustomTextStyles.b16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
