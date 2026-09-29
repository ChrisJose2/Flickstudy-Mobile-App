import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/common/widgets/custom_button.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/study/view_models/study_view_model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class WordListView extends StatefulWidget {
  @override
  WordListViewState createState() => WordListViewState();
}

class WordListViewState extends State<WordListView> {
  late StudyViewModel studyViewModel;

  double _startValue = 0;
  double _endValue = 25; // Corresponds to 'Z'
  List<String> _alphabets = List.generate(
      26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));

  @override
  void initState() {
    studyViewModel = Provider.of<StudyViewModel>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      studyViewModel.getWordList(startIndex: 0, endIndex: 25);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarViewV2(title: "Word list"),
          body: studyViewModel.wordListLoadingStatus
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : studyViewModel.wordListData != null &&
                      studyViewModel.wordListData!.wordList.isNotEmpty
                  ? Column(
                      children: [
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: AppColors.white,
                                    context: context,
                                    builder: (context) => StatefulBuilder(
                                        builder: (context, setState) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(height: 24),
                                            CustomTextField(
                                              text: "Find words between",
                                              styleFace: CustomTextStyles.b16,
                                            ),
                                            SizedBox(height: 36),
                                            CustomTextField(
                                              text:
                                                  " ${_alphabets[_startValue.toInt()]} - ${_alphabets[_endValue.toInt()]}",
                                              styleFace: CustomTextStyles.b35,
                                            ),
                                            SizedBox(height: 42),
                                            SfRangeSliderTheme(
                                              data: SfRangeSliderThemeData(
                                                  tooltipBackgroundColor:
                                                      AppColors.primary),
                                              child: SfRangeSlider(
                                                min: 0,
                                                max: 25, // Corresponds to 'Z'
                                                interval: 1,
                                                showTicks: false,
                                                showLabels: false,
                                                enableTooltip: true,
                                                shouldAlwaysShowTooltip: true,
                                                activeColor: AppColors.primary,
                                                values: SfRangeValues(
                                                    _startValue, _endValue),
                                                onChanged:
                                                    (SfRangeValues values) {
                                                  setState(() {
                                                    _startValue = values.start;
                                                    _endValue = values.end;
                                                  });
                                                },
                                                tooltipTextFormatterCallback:
                                                    (actualValue,
                                                        formattedText) {
                                                  int index =
                                                      actualValue.toInt();
                                                  if (index >= 0 &&
                                                      index <
                                                          _alphabets.length) {
                                                    return _alphabets[index];
                                                  }
                                                  return '';
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 24),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CustomButton(
                                                    text: "Apply",
                                                    onPressed: () {
                                                      studyViewModel
                                                          .getWordList(
                                                              startIndex:
                                                                  _startValue
                                                                      .toInt(),
                                                              endIndex:
                                                                  _endValue
                                                                      .toInt());
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _startValue = 0;
                                                      _endValue = 25;
                                                    });
                                                    studyViewModel.getWordList(
                                                        startIndex:
                                                            _startValue.toInt(),
                                                        endIndex:
                                                            _endValue.toInt());
                                                    Navigator.pop(context);
                                                  },
                                                  child: CustomTextField(
                                                      text: "Clear"),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 24),
                                          ],
                                        ),
                                      );
                                    }),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: studyViewModel.isListFiltered
                                              ? AppColors.primary
                                              : AppColors.grey,
                                          width: studyViewModel.isListFiltered
                                              ? 1.5
                                              : 1),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.filter_list_rounded,
                                        color: AppColors.black,
                                        size: 18,
                                      ),
                                      SizedBox(width: 8),
                                      CustomTextField(
                                        text: "Filter",
                                        styleFace: CustomTextStyles.b12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.bookmarkView);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.bookmark_border,
                                        color: AppColors.black,
                                        size: 18,
                                      ),
                                      SizedBox(width: 8),
                                      CustomTextField(
                                        text: "Bookmared",
                                        styleFace: CustomTextStyles.b12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.grey),
                                    borderRadius: BorderRadius.circular(8)),
                                child: CustomTextField(
                                  text: "Last studied",
                                  styleFace: CustomTextStyles.b12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Expanded(
                          child: AlphabetListView(
                            items: studyViewModel.alphabeticWordList,
                            options: AlphabetListViewOptions(
                              listOptions: ListOptions(
                                  listHeaderBuilder: (context, symbol) =>
                                      Container(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryLight),
                                          child: CustomTextField(
                                            text: symbol,
                                            styleFace: CustomTextStyles.maxb18,
                                          ),
                                        ),
                                      ),
                                  stickySectionHeader: true,
                                  backgroundColor: Colors.white),
                              overlayOptions: OverlayOptions(
                                showOverlay: true,
                                overlayBuilder: (context, symbol) => Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: CustomTextField(
                                      text: symbol,
                                      styleFace: CustomTextStyles.b20.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: CustomTextField(
                        text: 'Word list is empty',
                        styleFace: CustomTextStyles.r14,
                      ),
                    ),
        );
      },
    );
  }
}
