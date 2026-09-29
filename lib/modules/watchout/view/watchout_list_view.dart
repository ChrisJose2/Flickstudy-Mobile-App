import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/widgets/app_bar_v2.dart';
import 'package:flutter_architecture/modules/watchout/model/watchout_list_model.dart';
import 'package:flutter_architecture/modules/watchout/view_model/watchout_view_model.dart';
import 'package:provider/provider.dart';

import '../../../common/styles/custom_text_styles.dart';
import '../../../common/widgets/text_widget.dart';

class WatchOutListView extends StatefulWidget {
  WatchOutListView({Key? key}) : super(key: key);

  @override
  State<WatchOutListView> createState() => _WatchOutListViewState();
}

class _WatchOutListViewState extends State<WatchOutListView> {
  late WatchOutViewModel watchOutViewModel;

  @override
  void initState() {
    watchOutViewModel = Provider.of<WatchOutViewModel>(context, listen: false);
    super.initState();
  }

  String? categoryName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null && arguments is int) {
      print(arguments);
      watchOutViewModel.watchOutCategoryList!.watchOutCategory
          .forEach((element) {
        if (element.id == arguments) {
          categoryName = element.title;
        }
      });
      if (categoryName != null) {
        watchOutViewModel.getWatchOutList(arguments);
      }
    }
  }

  bool newsSelected = true;
  int selectedTile = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchOutViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarViewV2(title: categoryName ?? "Category"),
          body: watchOutViewModel.watchOutListLoadingStatus
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            watchOutViewModel.watchOutList!.watchOutList.length,
                        itemBuilder: (context, index) {
                          WatchOutValue watchOutValue = watchOutViewModel
                              .watchOutList!.watchOutList[index];
                          return Column(
                            children: [
                              ListTile(
                                leading: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: AppColors.grey)),
                                    child: Image.asset(
                                      "assets/imgs/watchout_view/exam_calendar.png",
                                      color: AppColors.primary,
                                    )),
                                title: Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: CustomTextField(
                                        text: watchOutValue.title,
                                        styleFace: CustomTextStyles.b14)),
                                subtitle: Container(
                                    margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: watchOutValue.description,
                                            style: CustomTextStyles.r14,
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: '... Read more',
                                                  style: CustomTextStyles
                                                      .r14.primary),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            CustomTextField(
                                                text: watchOutValue.created,
                                                styleFace: CustomTextStyles
                                                    .b12.darkGrey),
                                            SizedBox(width: 20),
                                          ],
                                        ),
                                      ],
                                    )),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.watchOutDetail,
                                      arguments: watchOutValue.id);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }
}
