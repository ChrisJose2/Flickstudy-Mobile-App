import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/test/view_model/test_view_model.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TestSolutionView extends StatefulWidget {
  @override
  TestSolutionViewViewState createState() => TestSolutionViewViewState();
}

class TestSolutionViewViewState extends State<TestSolutionView> {
  late TestViewModel testViewModel;

  @override
  void initState() {
    testViewModel = Provider.of<TestViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TestViewModel>(
      builder: (context, viewmodel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarViewV2(title: "Solutions"),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                      itemCount: testViewModel
                          .testQuestionsList!.questionModelList.length,
                      itemBuilder: (context, index) {
                        int totalOptions = 2;
                        if (testViewModel
                            .testQuestionsList!
                            .questionModelList[index]
                            .questions[0]
                            .option3
                            .isNotEmpty) {
                          totalOptions++;
                          if (testViewModel
                              .testQuestionsList!
                              .questionModelList[index]
                              .questions[0]
                              .option4
                              .isNotEmpty) {
                            totalOptions++;
                            if (testViewModel
                                .testQuestionsList!
                                .questionModelList[index]
                                .questions[0]
                                .option5
                                .isNotEmpty) {
                              totalOptions++;
                            }
                          }
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: CustomTextField(
                                text: NumberFormat('00')
                                    .format(index + 1)
                                    .toString(),
                                styleFace: CustomTextStyles.thickb14,
                              ),
                            ),
                            SizedBox(height: 20),
                            RichText(
                              text: TextSpan(
                                text: testViewModel
                                    .testQuestionsList!
                                    .questionModelList[index]
                                    .questions[0]
                                    .questionTitle,
                                style: CustomTextStyles.thickb14,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: testViewModel.testAnswers[index]
                                                  .values.first ==
                                              -1
                                          ? " (Not Attempted)"
                                          : testViewModel
                                                  .testQuestionsList!
                                                  .questionModelList[index]
                                                  .questions[0]
                                                  .answer
                                                  .contains(testViewModel
                                                      .testAnswers[index]
                                                      .values
                                                      .first
                                                      .toString())
                                              ? " (Correct)"
                                              : " (Wrong)",
                                      style: CustomTextStyles.sb12.copyWith(
                                          color: testViewModel
                                                      .testAnswers[index]
                                                      .values
                                                      .first ==
                                                  -1
                                              ? AppColors.yellow
                                              : testViewModel
                                                      .testQuestionsList!
                                                      .questionModelList[index]
                                                      .questions[0]
                                                      .answer
                                                      .contains(testViewModel
                                                          .testAnswers[index]
                                                          .values
                                                          .first
                                                          .toString())
                                                  ? AppColors.green
                                                  : AppColors.red)),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            for (int i = 1; i <= totalOptions; i++) ...[
                              TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefix: Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Container(
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
                                          styleFace: CustomTextStyles.thickb14,
                                        ))),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  enabled: false,
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: testViewModel
                                                  .testQuestionsList!
                                                  .questionModelList[index]
                                                  .questions[0]
                                                  .answer
                                                  .contains(i.toString())
                                              ? AppColors.green
                                              : testViewModel.testAnswers[index]
                                                          .values.first ==
                                                      i
                                                  ? AppColors.primary
                                                  : AppColors.black),
                                      borderRadius: BorderRadius.circular(8)),
                                  labelText: testViewModel
                                          .testQuestionsList!
                                          .questionModelList[index]
                                          .questions[0]
                                          .answer
                                          .contains(i.toString())
                                      ? "Correct"
                                      : testViewModel.testAnswers[index].values
                                                  .first ==
                                              i
                                          ? "Wrong"
                                          : "",
                                  labelStyle: TextStyle(
                                    color: testViewModel
                                            .testQuestionsList!
                                            .questionModelList[index]
                                            .questions[0]
                                            .answer
                                            .contains(i.toString())
                                        ? AppColors.green
                                        : testViewModel.testAnswers[index]
                                                    .values.first ==
                                                i
                                            ? AppColors.primary
                                            : AppColors.black,
                                  ),
                                ),
                                controller: TextEditingController(
                                  text: i == 1
                                      ? testViewModel
                                          .testQuestionsList!
                                          .questionModelList[index]
                                          .questions[0]
                                          .option1
                                      : i == 2
                                          ? testViewModel
                                              .testQuestionsList!
                                              .questionModelList[index]
                                              .questions[0]
                                              .option2
                                          : i == 3
                                              ? testViewModel
                                                  .testQuestionsList!
                                                  .questionModelList[index]
                                                  .questions[0]
                                                  .option3
                                              : i == 4
                                                  ? testViewModel
                                                      .testQuestionsList!
                                                      .questionModelList[index]
                                                      .questions[0]
                                                      .option4
                                                  : testViewModel
                                                      .testQuestionsList!
                                                      .questionModelList[index]
                                                      .questions[0]
                                                      .option5,
                                ),
                                style: CustomTextStyles.thickb14,
                              ),
                              // Container(
                              //   padding: EdgeInsets.all(15),
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     border: Border.all(
                              //         width: 1,
                              //         color: testViewModel
                              //                 .testQuestionsList!
                              //                 .questionModelList[index]
                              //                 .questions[0]
                              //                 .answer
                              //                 .contains(i.toString())
                              //             ? AppColors.green
                              //             : testViewModel.testAnswers[index]
                              //                         .values.first ==
                              //                     i
                              //                 ? AppColors.primary
                              //                 : AppColors.grey),
                              //   ),
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //           width: 30,
                              //           height: 30,
                              //           padding: EdgeInsets.all(5),
                              //           decoration: BoxDecoration(
                              //             color: AppColors.grey,
                              //             borderRadius:
                              //                 BorderRadius.circular(20),
                              //           ),
                              //           child: Center(
                              //               child: CustomTextField(
                              //             text: i == 1
                              //                 ? "A"
                              //                 : i == 2
                              //                     ? "B"
                              //                     : i == 3
                              //                         ? "C"
                              //                         : i == 4
                              //                             ? "D"
                              //                             : "E",
                              //             styleFace: CustomTextStyles.thickb14,
                              //           ))),
                              //       SizedBox(width: 20),
                              //       CustomTextField(
                              //         text: i == 1
                              //             ? testViewModel
                              //                 .testQuestionsList!
                              //                 .questionModelList[index]
                              //                 .questions[0]
                              //                 .option1
                              //             : i == 2
                              //                 ? testViewModel
                              //                     .testQuestionsList!
                              //                     .questionModelList[index]
                              //                     .questions[0]
                              //                     .option2
                              //                 : i == 3
                              //                     ? testViewModel
                              //                         .testQuestionsList!
                              //                         .questionModelList[index]
                              //                         .questions[0]
                              //                         .option3
                              //                     : i == 4
                              //                         ? testViewModel
                              //                             .testQuestionsList!
                              //                             .questionModelList[
                              //                                 index]
                              //                             .questions[0]
                              //                             .option4
                              //                         : testViewModel
                              //                             .testQuestionsList!
                              //                             .questionModelList[
                              //                                 index]
                              //                             .questions[0]
                              //                             .option5,
                              //         styleFace: CustomTextStyles.thickb14,
                              //       )
                              //     ],
                              //   ),
                              // ),
                              SizedBox(height: 20),
                            ],
                            SizedBox(height: 4),
                            Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextField(
                                      text: "Solution",
                                      styleFace: CustomTextStyles.sb12
                                          .copyWith(color: Colors.grey),
                                    ),
                                    SizedBox(height: 20),
                                    HtmlWidget(
                                      testViewModel
                                          .testQuestionsList!
                                          .questionModelList[index]
                                          .questions[0]
                                          .answerDescription,
                                      textStyle: CustomTextStyles.r14,
                                    ),
                                  ],
                                )),
                            SizedBox(height: 32),
                            // Divider(thickness: 2),
                            // SizedBox(height: 16),
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
