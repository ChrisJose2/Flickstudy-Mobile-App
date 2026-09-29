import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:flutter_architecture/common/utilities/utils.dart';
import 'package:flutter_architecture/common/widgets/app_bar.dart';
import 'package:flutter_architecture/modules/watchout/view_model/watchout_view_model.dart';
import 'package:provider/provider.dart';

class WatchoutView extends StatefulWidget {
  @override
  WatchoutViewState createState() => WatchoutViewState();
}

class WatchoutViewState extends State<WatchoutView> {
  late WatchOutViewModel watchOutViewModel;
  ValueNotifier<String> imageNotifier =
      ValueNotifier<String>(AppConstants.HOME_WATCH_HOPE1);
  Timer? timer;
  int index = 0;

  @override
  void initState() {
    watchOutViewModel = Provider.of<WatchOutViewModel>(context, listen: false);
    startImageAnimation();
    watchOutViewModel.getWatchOutCategoryList();
    super.initState();
  }

  startImageAnimation() {
    Timer.periodic(Duration(seconds: 3), (_t) {
      index++;
      timer = _t;
      imageNotifier.value = index % 2 == 0
          ? AppConstants.HOME_WATCH_HOPE1
          : AppConstants.HOME_WATCH_HOPE2;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.home, (Route<dynamic> route) => false);
        return true;
      },
      child: Consumer<WatchOutViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarView(),
            body: watchOutViewModel.watchOutCategoryLoadingStatus
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 10,
                            // textDirection: TextDirection.rtl,
                            children: [
                              for (int i = 0;
                                  i <
                                      watchOutViewModel.watchOutCategoryList!
                                          .watchOutCategory.length;
                                  i++)
                                if (i == 3)
                                  Row(
                                    children: [
                                      ValueListenableBuilder(
                                          valueListenable: imageNotifier,
                                          builder: (context, value, child) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              child: Image.network(
                                                imageNotifier.value,
                                                height:
                                                    (((MediaQuery.of(context)
                                                                        .size
                                                                        .width -
                                                                    60) /
                                                                3) *
                                                            2) +
                                                        10,
                                                width: (((MediaQuery.of(context)
                                                                    .size
                                                                    .width -
                                                                60) /
                                                            3) *
                                                        2) +
                                                    10,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            );
                                          }),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Container(
                                            width: Utilities.textCardWidth(
                                                context),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    AppRoutes.watchOutList,
                                                    arguments: watchOutViewModel
                                                        .watchOutCategoryList!
                                                        .watchOutCategory[3]
                                                        .id);
                                              },
                                              child: Utilities
                                                  .getCardWithImageText(
                                                      watchOutViewModel
                                                          .watchOutCategoryList!
                                                          .watchOutCategory[3]
                                                          .title,
                                                      watchOutViewModel
                                                          .watchOutCategoryList!
                                                          .watchOutCategory[3]
                                                          .image,
                                                      true),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            width: Utilities.textCardWidth(
                                                context),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    AppRoutes.watchOutList,
                                                    arguments: watchOutViewModel
                                                        .watchOutCategoryList!
                                                        .watchOutCategory[4]
                                                        .id);
                                              },
                                              child: Utilities
                                                  .getCardWithImageText(
                                                      watchOutViewModel
                                                          .watchOutCategoryList!
                                                          .watchOutCategory[4]
                                                          .title,
                                                      watchOutViewModel
                                                          .watchOutCategoryList!
                                                          .watchOutCategory[4]
                                                          .image,
                                                      true),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                else if (i != 4)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.watchOutList,
                                          arguments: watchOutViewModel
                                              .watchOutCategoryList!
                                              .watchOutCategory[i]
                                              .id);
                                    },
                                    child: Utilities.getCardWithImageText(
                                        watchOutViewModel.watchOutCategoryList!
                                            .watchOutCategory[i].title,
                                        watchOutViewModel.watchOutCategoryList!
                                            .watchOutCategory[i].image,
                                        true),
                                  ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
