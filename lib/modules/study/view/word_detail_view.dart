import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/study/models/word_list_model.dart';
import 'package:flutter_architecture/modules/study/view_models/study_view_model.dart';
import 'package:provider/provider.dart';

class WordDetailView extends StatefulWidget {
  @override
  WordDetailViewState createState() => WordDetailViewState();
}

class WordDetailViewState extends State<WordDetailView> {
  late StudyViewModel studyViewModel;

  @override
  void initState() {
    studyViewModel = Provider.of<StudyViewModel>(context, listen: false);
    super.initState();
  }

  String? wordName;
  int currentIndex = 0;
  List<WordData>? wordList;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null && wordList == null && arguments is Map) {
      // Store the word list and initialize current index
      wordList = arguments['wordList'] as List<WordData>;
      currentIndex = arguments['selectedIndex'] as int;

      // Load the initial word
      await _loadWord(currentIndex);
    }
  }

  Future<void> _loadWord(int index) async {
    if (wordList == null || index < 0 || index >= wordList!.length) {
      return;
    }

    setState(() {
      _isLoading = true;
      wordName = wordList![index].title;
    });

    try {
      await studyViewModel.getWordDetails(wordId: wordList![index].id);
      bookmarkId = studyViewModel.wordDetails!.bookmarkId;
    } catch (e) {
      // Handle error if needed
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToNextWord() {
    if (wordList != null && currentIndex < wordList!.length - 1) {
      currentIndex++;
      _loadWord(currentIndex);
    }
  }

  void _navigateToPreviousWord() {
    if (wordList != null && currentIndex > 0) {
      currentIndex--;
      _loadWord(currentIndex);
    }
  }

  int? bookmarkId;
  @override
  Widget build(BuildContext context) {
    return Consumer<StudyViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarViewV2(title: wordName ?? "Word-name"),
          body: GestureDetector(
            onVerticalDragEnd: (details) {
              // Swipe up (negative velocity) = next word
              // Swipe down (positive velocity) = previous word
              if (details.primaryVelocity != null) {
                if (details.primaryVelocity! < -500) {
                  // Swipe up - next word
                  _navigateToNextWord();
                } else if (details.primaryVelocity! > 500) {
                  // Swipe down - previous word
                  _navigateToPreviousWord();
                }
              }
            },
            child: _isLoading || studyViewModel.wordDetailsLoadingStatus
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : studyViewModel.wordDetails != null &&
                        studyViewModel.wordDetails!.wordListMedia.isNotEmpty
                    ? Column(
                        children: [
                          // SizedBox(height: 5),
                          IconButton(
                            onPressed: () async {
                              if (bookmarkId != null) {
                                int? tempId = bookmarkId;
                                bookmarkId = null;
                                setState(() {});
                                bool isAdded =
                                    await studyViewModel.deleteBookmarkWord(
                                        id: tempId!,
                                        wordId: studyViewModel
                                            .wordDetails!.wordDetail.id);
                                if (!isAdded) {
                                  bookmarkId = tempId;
                                  setState(() {});
                                }
                              } else {
                                bookmarkId = 0;
                                setState(() {});
                                bool isAdded =
                                    await studyViewModel.addBookmarkWord(
                                        wordId: studyViewModel
                                            .wordDetails!.wordDetail.id);
                                await studyViewModel.getWordDetails(
                                    wordId: studyViewModel
                                        .wordDetails!.wordDetail.id);
                                bookmarkId =
                                    studyViewModel.wordDetails!.bookmarkId;
                                setState(() {});
                                if (!isAdded) {
                                  bookmarkId = null;
                                  setState(() {});
                                }
                              }
                            },
                            icon: Icon(
                              bookmarkId != null
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: AppColors.black,
                            ),
                          ),
                          Expanded(
                            child: Image.network(
                              studyViewModel.wordDetails!.wordListMedia[0].file,
                              fit: BoxFit.contain,
                              width: double.infinity,
                            ),
                          ),
                          // Indicator showing current word position
                          if (wordList != null)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                '${currentIndex + 1} / ${wordList!.length}',
                                style: CustomTextStyles.r14,
                              ),
                            ),
                        ],
                      )
                    : Center(
                        child: CustomTextField(
                          text: 'Word details not found',
                          styleFace: CustomTextStyles.r14,
                        ),
                      ),
          ));
    });
  }
}
