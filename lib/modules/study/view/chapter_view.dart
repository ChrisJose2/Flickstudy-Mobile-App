import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:flutter_architecture/common/utilities/utils.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/modules/study/view_models/study_view_model.dart';
import 'package:provider/provider.dart';

class ChapterView extends StatefulWidget {
  @override
  ChapterViewState createState() => ChapterViewState();
}

class ChapterViewState extends State<ChapterView> {
  late StudyViewModel studyViewModel;

  @override
  void initState() {
    studyViewModel = Provider.of<StudyViewModel>(context, listen: false);
    super.initState();
  }

  String? subjectName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null && arguments is int) {
      print(arguments);
      int? courseId;
      studyViewModel.courseSubjects!.subjectList.forEach((element) {
        if (element.id == arguments) {
          subjectName = element.subjectTitle;
          courseId = element.courseId;
        }
      });
      if (courseId != null) {
        studyViewModel.getSubjectChapters(
            courseId: courseId!, subjectId: arguments);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarViewV2(title: subjectName ?? "Subject"),
          body: studyViewModel.chaptersLoadingStatus
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (var chapter
                                in studyViewModel.subjectChapters!.chapterList)
                              chapter.type == "chapter"
                                  ? Container(
                                      width: Utilities.textCardWidth(context),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, AppRoutes.topic,
                                              arguments: chapter.id);
                                        },
                                        child: Utilities.getCardWithImageText(
                                            chapter.chapterTitle,
                                            chapter.image,
                                            true
                                            /*NumberFormat('00')
                                                    .format(chapter.sNo)
                                                    .toString()*/
                                            ),
                                      ),
                                    )
                                  : Container(
                                      width: Utilities.imageCardWidth(context),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                  0.2), // Shadow color
                                              offset: Offset(2,
                                                  2), // Offset (horizontal, vertical)
                                              blurRadius:
                                                  2, // The blur effect of the shadow
                                              spreadRadius:
                                                  0, // How much the shadow spreads
                                            ),
                                          ],
                                          border: Border.all(
                                              width: 0.8,
                                              color: Colors.grey.shade200),
                                        ),
                                        child: Image.network(
                                          AppConstants.getRandomHopeHorizontal(),
                                          fit: BoxFit.cover,
                                          height: ((MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      60) /
                                                  3) -
                                              10,
                                        ),
                                      ),
                                    ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
