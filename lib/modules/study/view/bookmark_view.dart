import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/study/models/bookmark_list_model.dart';
import 'package:flutter_architecture/modules/study/view_models/study_view_model.dart';
import 'package:provider/provider.dart';

class BookmarkView extends StatefulWidget {
  @override
  BookmarkViewState createState() => BookmarkViewState();
}

class BookmarkViewState extends State<BookmarkView> {
  late StudyViewModel studyViewModel;

  @override
  void initState() {
    studyViewModel = Provider.of<StudyViewModel>(context, listen: false);
    studyViewModel.getBookmarkList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarViewV2(title: "Bookmarked"),
          body: studyViewModel.bookmarkListLoadingStatus
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: studyViewModel.bookmarkList!.bookmarkList.length,
                  itemBuilder: (context, index) {
                    Bookmark bookmark =
                        studyViewModel.bookmarkList!.bookmarkList[index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.wordDetail,
                                arguments: bookmark.wordId);
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  text: bookmark.wordIdTitle,
                                  styleFace: CustomTextStyles.thickb14,
                                ),
                              ),
                              SizedBox(width: 8),
                              IconButton(
                                onPressed: () async {
                                  await studyViewModel.deleteBookmarkWord(
                                      wordId: bookmark.wordId, id: bookmark.id);
                                  studyViewModel.getBookmarkList();
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
