import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/utilities/constants.dart';
import 'package:flutter_architecture/common/widgets/custom_button.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/authentication/user_model.dart';
import 'package:flutter_architecture/modules/user/user_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class NewSub extends StatefulWidget {
  const NewSub({super.key});

  @override
  State<NewSub> createState() => _NewSubState();
}

class _NewSubState extends State<NewSub> {
  Razorpay _razorpay = Razorpay();

  late UserViewModel userViewModel;

  @override
  void initState() {
    userViewModel = Provider.of<UserViewModel>(context, listen: false);
    UserViewModel().getPackageList();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });

    super.initState();
  }

  var options = {
    'key': 'rzp_test_Zempc2zvqO0KsS',
    'amount': 1500000,
    'name': 'Testing 1',
    'description': 'CAT Course',
    'prefill': {'contact': User().phone, 'email': User().email}
  };

  int selectedCourse = -1;

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await userViewModel.createSubscription(
      courseID: userViewModel.coursesModel!.packageCourse[selectedCourse].id,
      price: userViewModel.coursesModel!.packageCourse[selectedCourse].amount
          .toStringAsFixed(0),
      courseName:
          userViewModel.coursesModel!.packageCourse[selectedCourse].courseName,
      transactionId: response.paymentId ?? "",
    );
    if (userViewModel.isCreatedSubscription) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.payment_success,
      );
    } else {
      selectedCourse = -1;
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    selectedCourse = -1;
    Fluttertoast.showToast(
      msg: "Payment Failed",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, userViewModel, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: userViewModel.packageLoadingStatus
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0;
                          i < userViewModel.coursesModel!.packageCourse.length;
                          i++)
                        Stack(
                          children: [
                            Image.asset(
                              "assets/imgs/sub${i % 2 == 0 ? "" : "2"}.png",
                              height: MediaQuery.of(context).size.height -
                                  MediaQuery.of(context)
                                      .systemGestureInsets
                                      .top,
                              fit: BoxFit.fitHeight,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                                height: MediaQuery.of(context).size.height -
                                    MediaQuery.of(context)
                                        .systemGestureInsets
                                        .top -
                                    32 -
                                    300,
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextField(
                                      text: userViewModel.coursesModel!
                                          .packageCourse[i].courseName,
                                      styleFace: CustomTextStyles.medb35.white,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "Extensive ",
                                        style: CustomTextStyles.sb14.primary,
                                        children: [
                                          TextSpan(
                                            text: "Course",
                                            style: CustomTextStyles.sb14.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "Thorough ",
                                        style: CustomTextStyles.sb14.primary,
                                        children: [
                                          TextSpan(
                                            text: "Preparation",
                                            style: CustomTextStyles.sb14.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    CustomTextField(
                                      text:
                                          "Rs ${userViewModel.coursesModel!.packageCourse[i].fakePrice}",
                                      styleFace: CustomTextStyles.r16.white
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    CustomButton(
                                      text:
                                          "Buy Now Rs ${userViewModel.coursesModel!.packageCourse[i].amount.toStringAsFixed(0)}",
                                      onPressed: () {
                                        selectedCourse = i;
                                        options['amount'] = userViewModel
                                                .coursesModel!
                                                .packageCourse[i]
                                                .amount
                                                .toInt() *
                                            100;
                                        options['name'] = userViewModel
                                            .coursesModel!
                                            .packageCourse[i]
                                            .courseName;
                                        options['description'] = userViewModel
                                            .coursesModel!
                                            .packageCourse[i]
                                            .description
                                            .substring(0, 250);
                                        _razorpay.open(options);
                                      },
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.video,
                                            arguments: VideoArguments(
                                                videoLink: userViewModel
                                                    .coursesModel!
                                                    .packageCourse[i]
                                                    .benefitsLink,
                                                chapterId: null,
                                                subjectId: null,
                                                chapterTitle: null));
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.play_circle_outline_rounded,
                                            size: 36,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          CustomTextField(
                                            text: "Course Benefits",
                                            styleFace:
                                                CustomTextStyles.medb18.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.video,
                                            arguments: VideoArguments(
                                                videoLink: userViewModel
                                                    .coursesModel!
                                                    .packageCourse[i]
                                                    .previewLink,
                                                chapterId: null,
                                                subjectId: null,
                                                chapterTitle: null));
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.play_circle_outline_rounded,
                                            size: 36,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          CustomTextField(
                                            text: "Preview the course",
                                            styleFace:
                                                CustomTextStyles.medb18.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height -
                                        MediaQuery.of(context)
                                            .systemGestureInsets
                                            .top -
                                        32 -
                                        300,
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [],
                                    ),
                                  ),
                                ),
                                if (userViewModel.coursesModel!.packageCourse[i]
                                    .benefits.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      color: Colors.black.withOpacity(0.5),
                                      height: 300 - 32,
                                      padding: EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (int j = 0;
                                              j <
                                                  userViewModel
                                                      .coursesModel!
                                                      .packageCourse[i]
                                                      .benefits
                                                      .length;
                                              j++) ...[
                                            Row(
                                              children: [
                                                Image.network(
                                                  AppConstants.GALLERY_FOLDER +
                                                      userViewModel
                                                          .coursesModel!
                                                          .packageCourse[i]
                                                          .benefits[j]
                                                          .icon,
                                                  height: 32,
                                                  width: 32,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomTextField(
                                                      text: userViewModel
                                                          .coursesModel!
                                                          .packageCourse[i]
                                                          .benefits[j]
                                                          .title,
                                                      styleFace:
                                                          CustomTextStyles
                                                              .medb22.primary,
                                                    ),
                                                    CustomTextField(
                                                      text: userViewModel
                                                          .coursesModel!
                                                          .packageCourse[i]
                                                          .benefits[j]
                                                          .subtitle,
                                                      styleFace:
                                                          CustomTextStyles
                                                              .sb14.white,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            if (j !=
                                                userViewModel
                                                        .coursesModel!
                                                        .packageCourse[i]
                                                        .benefits
                                                        .length -
                                                    1)
                                              SizedBox(
                                                height: 12,
                                              ),
                                          ],
                                          // Row(
                                          //   children: [
                                          //     Icon(
                                          //       Icons.ac_unit_sharp,
                                          //       size: 36,
                                          //       color: Colors.white,
                                          //     ),
                                          //     SizedBox(
                                          //       width: 12,
                                          //     ),
                                          //     Column(
                                          //       crossAxisAlignment:
                                          //           CrossAxisAlignment.start,
                                          //       children: [
                                          //         CustomTextField(
                                          //           text: "800 Structure tests",
                                          //           styleFace: CustomTextStyles
                                          //               .medb22.primary,
                                          //         ),
                                          //         CustomTextField(
                                          //           text: "25000 Questions",
                                          //           styleFace: CustomTextStyles
                                          //               .sb14.white,
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
