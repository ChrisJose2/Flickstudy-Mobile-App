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

class TestListView extends StatefulWidget {
  final TestListArgs? initialArgs;

  TestListView({Key? key, this.initialArgs}) : super(key: key);

  @override
  State<TestListView> createState() => _TestListViewState();
}

class TestListArgs {
  final int? type;
  final String title;

  const TestListArgs({required this.type, required this.title});
}

class _TestListViewState extends State<TestListView> {
  bool allSelected = true;

  late StudyViewModel studyViewModel;
  late TestViewModel testViewModel;

  late TestListArgs _args;

  @override
  void initState() {
    studyViewModel = Provider.of<StudyViewModel>(context, listen: false);
    testViewModel = Provider.of<TestViewModel>(context, listen: false);
    // TestViewModel is a singleton — drop any cached test list from the
    // previous test type so the first build doesn't briefly render the wrong
    // tests under the new screen's title.
    testViewModel.testCalenderModel = null;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Resolve args once (route args take precedence over constructor args).
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    _args = (routeArgs is TestListArgs)
        ? routeArgs
        : (widget.initialArgs ??
            const TestListArgs(type: null, title: "Test"));

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      testViewModel.getTestCalenderList(
          courseId: studyViewModel.userPackage!.packageList[0].courses[0].id,
          subjectId: null,
          type: _args.type);
      // Sessions are needed to filter the "Completed" tab.
      testViewModel.getTestSessionList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyViewModel>(builder: (context, viewmodel1, child) {
      return Consumer<TestViewModel>(builder: (context, viewmodel2, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarViewV2(title: _args.title),
          body: testViewModel.testCalenderLoadingStatus ||
                  studyViewModel.subjectsLoadingStatus ||
                  testViewModel.testCalenderModel == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : Builder(builder: (context) {
                  // Filter the test list based on the All/Completed tab.
                  // A test is considered "Completed" when its testpaper id is
                  // present in the user's saved test sessions.
                  final completedIds = testViewModel.testSessionList
                      .map((s) => s.testpaper_id)
                      .toSet();
                  final allTests =
                      testViewModel.testCalenderModel!.testData;
                  final List<TestData> displayedTests = allSelected
                      ? allTests
                      : allTests
                          .where((t) => completedIds.contains(t.id))
                          .toList();
                  return Padding(
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
                                      width: MediaQuery.of(context)
                                              .size
                                              .width /
                                          2,
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
                                      width: MediaQuery.of(context)
                                              .size
                                              .width /
                                          2,
                                      height: 2,
                                      color: AppColors.primary,
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Subject bottom-sheet dropdown removed per product
                        // request.
                        SizedBox(height: 20),
                        Expanded(
                          child: displayedTests.isEmpty
                              ? Center(
                                  child: CustomTextField(
                                    text: allSelected
                                        ? "No tests available."
                                        : "No completed tests yet.",
                                    styleFace:
                                        CustomTextStyles.b14.darkGrey,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: displayedTests.length,
                                  itemBuilder: (context, index) {
                                    TestData testData =
                                        displayedTests[index];
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: Container(
                                              padding: EdgeInsets.all(10),
                                              child: CustomTextField(
                                                text: NumberFormat('00')
                                                    .format(index + 1)
                                                    .toString(),
                                                styleFace: CustomTextStyles
                                                    .thickb22.darkGrey,
                                              )),
                                          title: Container(
                                              margin:
                                                  EdgeInsets.fromLTRB(
                                                      0, 10, 0, 0),
                                              child: CustomTextField(
                                                  text: testData
                                                      .testpaperTitle,
                                                  styleFace:
                                                      CustomTextStyles
                                                          .b12)),
                                          subtitle: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: CustomTextField(
                                                        text:
                                                            "${testData.totalTime} mins",
                                                        styleFace:
                                                            CustomTextStyles
                                                                .b12
                                                                .darkGrey),
                                          ),
                                          trailing: Icon(
                                            Icons.arrow_forward_rounded,
                                            size: 18,
                                            color: AppColors.darkGrey,
                                          ),
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                AppRoutes.test_detail,
                                                arguments: testData.id);
                                          },
                                        ),
                                        if (index !=
                                            displayedTests.length - 1)
                                          Divider(),
                                      ],
                                    );
                                  },
                                ),
                        )
                      ],
                    ),
                  );
                }),
        );
      });
    });
  }

}
