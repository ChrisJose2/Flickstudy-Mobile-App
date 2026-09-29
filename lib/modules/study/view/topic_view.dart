import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/study/models/chapter_model.dart';
import 'package:flutter_architecture/modules/study/models/topic_model.dart';
import 'package:flutter_architecture/modules/study/view/quiz_view.dart';
import 'package:flutter_architecture/modules/study/view_models/study_view_model.dart';
import 'package:provider/provider.dart';

class TopicView extends StatefulWidget {
  @override
  TopicViewState createState() => TopicViewState();
}

class TopicViewState extends State<TopicView> {
  late StudyViewModel studyViewModel;

  @override
  void initState() {
    studyViewModel = Provider.of<StudyViewModel>(context, listen: false);
    super.initState();
  }

  Chapter? chapter;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null && arguments is int) {
      print(arguments);
      studyViewModel.subjectChapters!.chapterList.forEach((element) {
        if (element.id == arguments) {
          chapter = element;
        }
      });
      if (chapter != null) {
        studyViewModel.getChapterTopics(chapterId: arguments);
      }
    }
  }

  int selectedTile = -1;
  @override
  Widget build(BuildContext context) {
    return Consumer<StudyViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarViewV2(title: chapter?.chapterTitle ?? "Chapter"),
          body: studyViewModel.topicsLoadingStatus
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                        child: getTimelineUI(
                            studyViewModel.chapterTopics!.topicList)),
                  ],
                ));
    });
  }

  // Widget getTimelineUI(List<Topic> topicData) {
  //   Widget contents(index) {
  //     return Padding(
  //       padding: const EdgeInsets.only(right: 20, bottom: 20),
  //       child: ExpansionTile(
  //             key: Key(index.toString()),
  //             initiallyExpanded: index == selectedTile,
  //             shape: Border(),
  //             dense: true,
  //             tilePadding: EdgeInsets.zero,
  //             childrenPadding: EdgeInsets.zero,
  //             title: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 CustomTextField(
  //                   text: topicData[index].topicTitle,
  //                   styleFace: CustomTextStyles.thickb14,
  //                 ),
  //               ],
  //             ),
  //             trailing: topicData[index].lessons != null &&
  //                     topicData[index].lessons!.isNotEmpty
  //                 ? Icon(
  //                     selectedTile == index
  //                         ? Icons.keyboard_arrow_up
  //                         : Icons.keyboard_arrow_down,
  //                     color: AppColors.black,
  //                   )
  //                 : Icon(Icons.abc, color: Colors.transparent),
  //             enabled: topicData[index].lessons != null &&
  //                     topicData[index].lessons!.isNotEmpty
  //                 ? true
  //                 : false,
  //             onExpansionChanged: ((newState) {
  //               if (newState) {
  //                 setState(() {
  //                   selectedTile = index;
  //                 });
  //               } else {
  //                 setState(() {
  //                   selectedTile = -1;
  //                 });
  //               }
  //             }),
  //             children: [
  //               if (topicData[index].lessons != null &&
  //                   topicData[index].lessons!.isNotEmpty)
  //                 for (Lessons lesson in topicData[index].lessons!)
  //                   ListTile(
  //                     dense: true,
  //                     onTap: () {
  //                       Navigator.pushNamed(context, AppRoutes.video,
  //                           arguments: VideoArguments(
  //                               videoLink: lesson.videoUrl,
  //                               chapterId: chapter!.id,
  //                               subjectId: chapter!.subjectId,
  //                               chapterTitle: chapter!.chapterTitle));
  //                     },
  //                     title: Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         Image.asset(
  //                           "assets/imgs/chapter_view/play_circle_outline.png",
  //                           height: 25,
  //                         ),
  //                         SizedBox(width: 20),
  //                         Expanded(
  //                             child: CustomTextField(
  //                           text: lesson.lessonTitle,
  //                           styleFace: CustomTextStyles.r14,
  //                         )),
  //                         SizedBox(width: 20),
  //                         CustomTextField(
  //                           text: '12:00',
  //                           styleFace: CustomTextStyles.r12.darkGrey,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //             ],
  //           ),
  //     );
  //   }
  //
  //   return Timeline.tileBuilder(
  //     padding: EdgeInsets.zero,
  //     shrinkWrap: true,
  //     physics: const BouncingScrollPhysics(),
  //     builder: TimelineTileBuilder.connected(
  //       contentsAlign: ContentsAlign.basic,
  //       itemCount: topicData.length,
  //       indicatorBuilder: (BuildContext context, int index) {
  //         Container(
  //           height: 40,
  //           width: 40,
  //           decoration: BoxDecoration(
  //             color: Colors.green,
  //             borderRadius: BorderRadius.circular(24),
  //             border: Border.all(color: AppColors.primary, width: 5),
  //           ),
  //         );
  //       },
  //       indicatorPositionBuilder: (context, index) => 1,
  //       // nodePositionBuilder: (context, index) => 0,
  //       connectorBuilder: (BuildContext context, int index, _) {
  //         return Connector.dashedLine(
  //           gap: 8,
  //           dash: 5,
  //           color: AppColors.primary,
  //           thickness: 5,
  //         );
  //       },
  //       contentsBuilder: (BuildContext context, int index) {
  //         return contents(index);
  //       },
  //     ),
  //   );
  // }

  Widget getTimelineUI(List<Topic> topicData) {
    Widget contents(index) {
      return Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 0),
        child: ExpansionTile(
          key: Key(index.toString()),
          initiallyExpanded: index == selectedTile,
          shape: const Border(),
          clipBehavior: Clip.hardEdge,
          dense: true,
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextField(
                text: topicData[index].topicTitle,
                styleFace: CustomTextStyles.thickb14,
              ),
            ],
          ),
          trailing: topicData[index].lessons != null &&
                  topicData[index].lessons!.isNotEmpty
              ? Icon(
                  selectedTile == index
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.black,
                )
              : const Icon(Icons.abc, color: Colors.transparent),
          enabled: topicData[index].lessons != null &&
                  topicData[index].lessons!.isNotEmpty
              ? true
              : false,
          onExpansionChanged: ((newState) {
            if (newState) {
              setState(() {
                selectedTile = index;
              });
            } else {
              setState(() {
                selectedTile = -1;
              });
            }
          }),
          children: [
            if (topicData[index].lessons != null &&
                topicData[index].lessons!.isNotEmpty)
              for (Lessons lesson in topicData[index].lessons!)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  minVerticalPadding: 0,
                  onTap: () {
                    if (lesson.type == 1) {
                      Navigator.pushNamed(context, AppRoutes.video,
                          arguments: VideoArguments(
                              videoLink: lesson.videoUrl,
                              chapterId: chapter!.id,
                              subjectId: chapter!.subjectId,
                              chapterTitle: chapter!.chapterTitle));
                      return;
                    }

                    if (lesson.type == 3) {
                      Navigator.pushNamed(context, AppRoutes.quiz,
                          arguments: QuizArgs(
                              testPaperId: lesson.refrenceId,
                              title: lesson.lessonTitle));
                      return;
                    }
                    Navigator.pushNamed(context, AppRoutes.comprehension);
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Image.asset(
                      //   "assets/imgs/chapter_view/play_circle_outline.png",
                      //   height: 25,
                      // ),
                      // SizedBox(width: 20),
                      Expanded(
                          child: CustomTextField(
                        text: lesson.lessonTitle,
                        styleFace: CustomTextStyles.r14,
                      )),
                      // const SizedBox(width: 20),
                      // CustomTextField(
                      //   text: '12:00',
                      //   styleFace: CustomTextStyles.r12.darkGrey,
                      // )
                    ],
                  ),
                ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: topicData.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(child: contents(index)),
          ],
        );
      },
    );
  }
}
