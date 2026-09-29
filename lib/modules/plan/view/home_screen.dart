import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/utilities/theme_provider.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/plan/view/plan_view.dart';
import 'package:flutter_architecture/modules/study/view/study_view.dart';
import 'package:flutter_architecture/modules/study/view_models/study_view_model.dart';
import 'package:flutter_architecture/modules/test/view/test_view.dart';
import 'package:flutter_architecture/modules/test_analysis/view/test_analysis_view.dart';
import 'package:flutter_architecture/modules/watchout/view/watchout_view.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _pageController = PageController(initialPage: 0);

  int selectedIndex = 0;

  late StudyViewModel studyViewModel;

  @override
  void initState() {
    studyViewModel = Provider.of<StudyViewModel>(context, listen: false);
    loadDatas();
    super.initState();
  }

  void loadDatas() {
    studyViewModel.getUserPackage();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    PlanScreen(),
    StudyView(),
    TestAnalysisView(),
    TestView(),
    WatchoutView(),
    // TestAnalysisView(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          floatingActionButton: GestureDetector(
            onTap: () {
              _pageController.jumpToPage(2);
              selectedIndex = 2;
              setState(() {});
            },
            child: Container(
                decoration: BoxDecoration(
                  // color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(100),
                ),
                height: screenHeight * 0.08,
                width: screenHeight * 0.08,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/imgs/big_picture.png",
                      height: screenHeight * 0.08,
                    ),
                  ],
                )),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomAppBar(
            padding: EdgeInsets.zero,
            clipBehavior: Clip.hardEdge,
            height: screenHeight * 0.085,
            color: AppColors.white,
            // elevation: 10,
            shape: const CircularNotchedRectangle(),
            notchMargin: 8,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      padding: EdgeInsets.only(left: 30, right: 0),
                      icon: Image.asset(
                        "assets/imgs/compass.png",
                        height: screenHeight * 0.027,
                        color: selectedIndex == 0
                            ? themeProvider.primary
                            : AppColors.black,
                      ),
                      onPressed: () {
                        _pageController.jumpToPage(0);
                        selectedIndex = 0;
                        setState(() {});
                      },
                    ),
                    CustomTextField(
                      text: "Plan",
                      styleFace: selectedIndex == 0
                          ? CustomTextStyles.b12.primary
                          : CustomTextStyles.r12.darkGrey,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      padding: EdgeInsets.only(right: 30, left: 4),
                      icon: Image.asset(
                        "assets/imgs/study.png",
                        height: screenHeight * 0.031,
                        color: selectedIndex == 1
                            ? themeProvider.primary
                            : AppColors.black,
                      ),
                      onPressed: () {
                        _pageController.jumpToPage(1);
                        selectedIndex = 1;
                        setState(() {});
                      },
                    ),
                    CustomTextField(
                      text: "Study",
                      styleFace: selectedIndex == 1
                          ? CustomTextStyles.b12.primary
                          : CustomTextStyles.r12.darkGrey,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      padding: EdgeInsets.only(right: 0, left: 30),
                      icon: Image.asset(
                        "assets/imgs/test.png",
                        height: screenHeight * 0.031,
                        color: selectedIndex == 3
                            ? themeProvider.primary
                            : AppColors.black,
                      ),
                      onPressed: () {
                        _pageController.jumpToPage(3);
                        selectedIndex = 3;
                        setState(() {});
                      },
                    ),
                    CustomTextField(
                      text: "Test",
                      styleFace: selectedIndex == 3
                          ? CustomTextStyles.b12.primary
                          : CustomTextStyles.r12.darkGrey,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      padding: EdgeInsets.only(right: 30, left: 5),
                      icon: Image.asset(
                        "assets/imgs/volume.png",
                        height: screenHeight * 0.027,
                        color: selectedIndex == 4
                            ? themeProvider.primary
                            : AppColors.black,
                      ),
                      onPressed: () {
                        _pageController.jumpToPage(4);
                        selectedIndex = 4;
                        setState(() {});
                      },
                    ),
                    CustomTextField(
                      text: "Watch",
                      styleFace: selectedIndex == 4
                          ? CustomTextStyles.b12.primary
                          : CustomTextStyles.r12.darkGrey,
                    )
                  ],
                ),
              ],
            ),
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              selectedIndex = index;
              setState(() {});
            },
            children: List.generate(
                bottomBarPages.length, (index) => bottomBarPages[index]),
          ),
        );
      },
    );
  }
}
