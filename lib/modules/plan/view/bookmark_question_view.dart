import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/test/model/test_questions_model.dart';
import 'package:flutter_architecture/modules/test/view_model/test_view_model.dart';
import 'package:provider/provider.dart';

class BookmarkQuestionView extends StatefulWidget {
  @override
  BookmarkQuestionViewState createState() => BookmarkQuestionViewState();
}

class BookmarkQuestionViewState extends State<BookmarkQuestionView> {
  late TestViewModel testViewModel;

  @override
  void initState() {
    testViewModel = Provider.of<TestViewModel>(context, listen: false);
    testViewModel.getBookmarkQuestionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TestViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarViewV2(title: "Bookmarked"),
          body: testViewModel.bookmarkListLoadingStatus
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: testViewModel
                      .bookmarkQuestionList!.bookmarkQuestionItems.length,
                  itemBuilder: (context, index) {
                    QuestionModel bookmarkQuestion = testViewModel
                        .bookmarkQuestionList!.bookmarkQuestionItems[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, AppRoutes.wordDetail,
                            //     arguments: bookmark.wordId);
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  text: bookmarkQuestion.questionTitle,
                                  styleFace: CustomTextStyles.thickb14,
                                ),
                              ),
                              SizedBox(width: 8),
                              IconButton(
                                onPressed: () async {
                                  await testViewModel.removeBookmarkQuestion(
                                      questionId:
                                          bookmarkQuestion.id.toString(),
                                      id: bookmarkQuestion.bookmarkId!);
                                  testViewModel.getBookmarkQuestionList();
                                },
                                icon: Icon(
                                  Icons.bookmark,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(color: AppColors.grey, thickness: 1),
                      ],
                    );
                  },
                ),
        );
      },
    );
  }
}
