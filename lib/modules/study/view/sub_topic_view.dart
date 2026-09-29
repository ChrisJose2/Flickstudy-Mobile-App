import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/study/models/topic_model.dart';
import 'package:flutter_architecture/modules/study/view_models/study_view_model.dart';
import 'package:provider/provider.dart';

class SubTopicView extends StatefulWidget {
  @override
  SubTopicViewState createState() => SubTopicViewState();
}

class SubTopicViewState extends State<SubTopicView> {
  late StudyViewModel studyViewModel;

  @override
  void initState() {
    studyViewModel = Provider.of<StudyViewModel>(context, listen: false);
    super.initState();
  }

  Topic? topic;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null && arguments is int) {
      print(arguments);
      studyViewModel.chapterTopics!.topicList.forEach((element) {
        if (element.id == arguments) {
          topic = element;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarViewV2(
                title: topic == null ? "Topic" : topic!.topicTitle),
            body: topic == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextField(
                                text: "01",
                                styleFace: CustomTextStyles.thickb16.darkGrey,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CustomTextField(
                                text: 'Verbal Ability',
                                styleFace: CustomTextStyles.thickb14,
                              ),
                            ],
                          ),
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: CustomTextField(
                                    text: 'Verbal Ability',
                                    styleFace: CustomTextStyles.r14,
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomTextField(
                                    text: '12:00',
                                    styleFace: CustomTextStyles.r12.darkGrey,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.video);
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: CustomTextField(
                                    text: 'Verbal Ability',
                                    styleFace: CustomTextStyles.r14,
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomTextField(
                                    text: '12:00',
                                    styleFace: CustomTextStyles.r12.darkGrey,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                AppRoutes.comprehension);
                                          },
                                          child: CustomTextField(
                                            text: 'Reading Comprehension',
                                            styleFace: CustomTextStyles.r14,
                                          ))),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.comprehension);
                                      },
                                      child: Icon(
                                        Icons.arrow_right_alt,
                                        color: AppColors.darkGrey,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextField(
                                text: "01",
                                styleFace: CustomTextStyles.thickb16.darkGrey,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CustomTextField(
                                text: 'Verbal Ability',
                                styleFace: CustomTextStyles.thickb14,
                              ),
                            ],
                          ),
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: CustomTextField(
                                    text: 'Verbal Ability',
                                    styleFace: CustomTextStyles.r14,
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomTextField(
                                    text: '12:00',
                                    styleFace: CustomTextStyles.r12.darkGrey,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.video);
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: CustomTextField(
                                    text: 'Verbal Ability',
                                    styleFace: CustomTextStyles.r14,
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomTextField(
                                    text: '12:00',
                                    styleFace: CustomTextStyles.r12.darkGrey,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                AppRoutes.comprehension);
                                          },
                                          child: CustomTextField(
                                            text: 'Reading Comprehension',
                                            styleFace: CustomTextStyles.r14,
                                          ))),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.comprehension);
                                      },
                                      child: Icon(
                                        Icons.arrow_right_alt,
                                        color: AppColors.darkGrey,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextField(
                                text: "01",
                                styleFace: CustomTextStyles.thickb16.darkGrey,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CustomTextField(
                                text: 'Verbal Ability',
                                styleFace: CustomTextStyles.thickb14,
                              ),
                            ],
                          ),
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: CustomTextField(
                                    text: 'Verbal Ability',
                                    styleFace: CustomTextStyles.r14,
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomTextField(
                                    text: '12:00',
                                    styleFace: CustomTextStyles.r12.darkGrey,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.video);
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: CustomTextField(
                                    text: 'Verbal Ability',
                                    styleFace: CustomTextStyles.r14,
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomTextField(
                                    text: '12:00',
                                    styleFace: CustomTextStyles.r12.darkGrey,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                AppRoutes.comprehension);
                                          },
                                          child: CustomTextField(
                                            text: 'Reading Comprehension',
                                            styleFace: CustomTextStyles.r14,
                                          ))),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.comprehension);
                                      },
                                      child: Icon(
                                        Icons.arrow_right_alt,
                                        color: AppColors.darkGrey,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextField(
                                text: "01",
                                styleFace: CustomTextStyles.thickb16.darkGrey,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CustomTextField(
                                text: 'Verbal Ability',
                                styleFace: CustomTextStyles.thickb14,
                              ),
                            ],
                          ),
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: CustomTextField(
                                    text: 'Verbal Ability',
                                    styleFace: CustomTextStyles.r14,
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomTextField(
                                    text: '12:00',
                                    styleFace: CustomTextStyles.r12.darkGrey,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.video);
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: CustomTextField(
                                    text: 'Verbal Ability',
                                    styleFace: CustomTextStyles.r14,
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomTextField(
                                    text: '12:00',
                                    styleFace: CustomTextStyles.r12.darkGrey,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                AppRoutes.comprehension);
                                          },
                                          child: CustomTextField(
                                            text: 'Reading Comprehension',
                                            styleFace: CustomTextStyles.r14,
                                          ))),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.comprehension);
                                      },
                                      child: Icon(
                                        Icons.arrow_right_alt,
                                        color: AppColors.darkGrey,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextField(
                                text: "01",
                                styleFace: CustomTextStyles.thickb16.darkGrey,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CustomTextField(
                                text: 'Verbal Ability',
                                styleFace: CustomTextStyles.thickb14,
                              ),
                            ],
                          ),
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: CustomTextField(
                                    text: 'Verbal Ability',
                                    styleFace: CustomTextStyles.r14,
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomTextField(
                                    text: '12:00',
                                    styleFace: CustomTextStyles.r12.darkGrey,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.video);
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: CustomTextField(
                                    text: 'Verbal Ability',
                                    styleFace: CustomTextStyles.r14,
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomTextField(
                                    text: '12:00',
                                    styleFace: CustomTextStyles.r12.darkGrey,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                AppRoutes.comprehension);
                                          },
                                          child: CustomTextField(
                                            text: 'Reading Comprehension',
                                            styleFace: CustomTextStyles.r14,
                                          ))),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.comprehension);
                                      },
                                      child: Icon(
                                        Icons.arrow_right_alt,
                                        color: AppColors.darkGrey,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextField(
                                text: "01",
                                styleFace: CustomTextStyles.thickb16.darkGrey,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              CustomTextField(
                                text: 'Verbal Ability',
                                styleFace: CustomTextStyles.thickb14,
                              ),
                            ],
                          ),
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: CustomTextField(
                                    text: 'Verbal Ability',
                                    styleFace: CustomTextStyles.r14,
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomTextField(
                                    text: '12:00',
                                    styleFace: CustomTextStyles.r12.darkGrey,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.video);
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: CustomTextField(
                                    text: 'Verbal Ability',
                                    styleFace: CustomTextStyles.r14,
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CustomTextField(
                                    text: '12:00',
                                    styleFace: CustomTextStyles.r12.darkGrey,
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/imgs/chapter_view/play_circle_outline.png",
                                    height: MediaQuery.of(context).size.height * 0.03125,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                AppRoutes.comprehension);
                                          },
                                          child: CustomTextField(
                                            text: 'Reading Comprehension',
                                            styleFace: CustomTextStyles.r14,
                                          ))),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.comprehension);
                                      },
                                      child: Icon(
                                        Icons.arrow_right_alt,
                                        color: AppColors.darkGrey,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Add more ExpansionTiles or other widgets as needed
                      ],
                    ),
                  ));
      },
    );
  }
}
