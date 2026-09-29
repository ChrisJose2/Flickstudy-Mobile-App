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

class PreviousYearPaperListView extends StatefulWidget {
  PreviousYearPaperListView({Key? key}) : super(key: key);

  @override
  State<PreviousYearPaperListView> createState() =>
      _PreviousYearPaperListViewState();
}

class _PreviousYearPaperListViewState extends State<PreviousYearPaperListView> {
  late TestViewModel testViewModel;

  @override
  void initState() {
    testViewModel = Provider.of<TestViewModel>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      testViewModel.getTestCalenderList(
          courseId: StudyViewModel().userPackage!.packageList[0].courses[0].id,
          subjectId: null,
          type: 3);
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
          appBar: AppBarViewV2(title: "Test"),
          body: testViewModel.testCalenderLoadingStatus
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
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
}
