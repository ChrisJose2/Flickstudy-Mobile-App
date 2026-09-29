import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:flutter_architecture/common/utilities/utils.dart';
import 'package:flutter_architecture/common/widgets/app_bar.dart';
import 'package:flutter_architecture/modules/user/model/student_subscription.dart';
import 'package:flutter_architecture/modules/user/user_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PlanScreen extends StatefulWidget {
  @override
  PlanScreenState createState() => PlanScreenState();
}

class PlanScreenState extends State<PlanScreen> {
  //${AppLocalizations.of(context)!.helloWorld
  String selectedType = AppConstants.PLAN;
  ValueNotifier<String> imageNotifier =
      ValueNotifier<String>(AppConstants.HOME_PLAN_HOPE1);
  Timer? timer;
  int index = 0;
  SubscriptionModel? subscriptionModel;
  @override
  void initState() {
    startImageAnimation();
    super.initState();
    UserViewModel().checkStudentSubscription().then(
        (value) => subscriptionModel = UserViewModel().studentSubscription);
  }

  startImageAnimation() {
    Timer.periodic(Duration(seconds: 3), (_t) {
      index++;
      timer = _t;
      imageNotifier.value = index % 2 == 0
          ? AppConstants.HOME_PLAN_HOPE1
          : AppConstants.HOME_PLAN_HOPE2;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarView(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () async {
                        Navigator.pushNamed(context, AppRoutes.study_calendar);
                      },
                      child: Utilities.getCardWithImageText("Study Calendar",
                          AppConstants.PLAN_STUDY_CALENDAR, true)),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.test_calendar);
                    },
                    child: Utilities.getCardWithImageText(
                        "Test Calendar", AppConstants.PLAN_TEST_CALENDAR, true),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.chapters_covered);
                    },
                    child: Utilities.getCardWithImageText("Chapters Covered",
                        AppConstants.PLAN_CHAPTERS_COVERED, true),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushNamed(context, AppRoutes.big_picture);
                  //   },
                  //   child: Utilities.getCardWithImageText("Big Picture",
                  //       "assets/imgs/plan_view/plan_big_picture.png"),
                  // )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height:
                        (((MediaQuery.of(context).size.width - 60) / 3) * 2) +
                            10,
                    width:
                        (((MediaQuery.of(context).size.width - 60) / 3) * 2) +
                            10,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.2), // Shadow color
                            offset:
                                Offset(2, 2), // Offset (horizontal, vertical)
                            blurRadius: 2, // The blur effect of the shadow
                            spreadRadius: 0, // How much the shadow spreads
                          ),
                        ],
                        borderRadius: BorderRadius.circular(16)),
                    child: Stack(
                      children: [
                        ValueListenableBuilder(
                            valueListenable: imageNotifier,
                            builder: (context, value, child) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.network(
                                  imageNotifier.value,
                                  height: (((MediaQuery.of(context).size.width -
                                                  60) /
                                              3) *
                                          2) +
                                      10,
                                  width: (((MediaQuery.of(context).size.width -
                                                  60) /
                                              3) *
                                          2) +
                                      10,
                                  fit: BoxFit.fitWidth,
                                ),
                              );
                            }),
                        if (subscriptionModel != null &&
                            subscriptionModel!.data.length > 0)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                final Uri whatsappUrl = Uri.parse(
                                    'https://wa.me/${AppConstants.WHATSAPP_NUMBER}');

                                if (await canLaunchUrl(whatsappUrl)) {
                                  await launchUrl(whatsappUrl,
                                      mode: LaunchMode.externalApplication);
                                } else {
                                  // Fallback: try alternative WhatsApp URL format
                                  final Uri altUrl = Uri.parse(
                                      'https://api.whatsapp.com/send?phone=${AppConstants.WHATSAPP_NUMBER}');
                                  if (await canLaunchUrl(altUrl)) {
                                    await launchUrl(altUrl,
                                        mode: LaunchMode.externalApplication);
                                  }
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.015,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16.0),
                                    bottomRight: Radius.circular(16.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.chat,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.height *
                                          0.02,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Enroll now',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.01875,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        else
                          Container(),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.assessment_status);
                        },
                        child: Utilities.getCardWithImageText(
                            "Assessment Status",
                            AppConstants.PLAN_ASSESSMENT_STATUS,
                            true),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.bookmark_question_view);
                        },
                        child: Utilities.getCardWithImageText(
                            "Bookmarked Questions",
                            AppConstants.PLAN_BOOKMARKED_QUESTIONS,
                            true),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width - 60) / 3,
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: (MediaQuery.of(context).size.width - 60) / 3,
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.test_completed);
                    },
                    child: Utilities.getCardWithImageText("Tests Completed",
                        AppConstants.PLAN_TESTS_COMPLETED, true),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
