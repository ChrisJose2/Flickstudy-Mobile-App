import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/app_bar.dart';
import 'package:flutter_architecture/common/widgets/custom_button.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/authentication/user_model.dart';
import 'package:flutter_architecture/modules/user/profile/view_model/profile_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  @override
  final GlobalKey globalKey = GlobalKey();

  late ProfileViewModel profileViewModel;
  bool isLoading = false;

  TextEditingController nameController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.home, (Route<dynamic> route) => false);
        return true;
      },
      child: Consumer<ProfileViewModel>(builder: (context, viewmodel, child) {
        return Scaffold(
          appBar: AppBarView(),
          body: Container(
            color: AppColors.white,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          //could change this to Color(0xFF737373),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Row(
                        children: [
                          // SizedBox(width: 16),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomTextField(
                                              text: User().name,
                                              color: AppColors.white,
                                              styleFace:
                                                  CustomTextStyles.b20.white,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) {
                                                  return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom,
                                                          left: 16,
                                                          right: 16),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SizedBox(height: 24),
                                                          CustomTextField(
                                                            text: "Update Name",
                                                            styleFace:
                                                                CustomTextStyles
                                                                    .sb20,
                                                          ),
                                                          SizedBox(height: 10),
                                                          TextField(
                                                            maxLines: 1,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          12,
                                                                      vertical:
                                                                          8),
                                                              hintText:
                                                                  "Enter your name",
                                                              hintStyle:
                                                                  CustomTextStyles
                                                                      .medb14
                                                                      .darkGrey,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                            controller:
                                                                nameController,
                                                            onChanged: (value) {
                                                              setState(() {});
                                                            },
                                                          ),
                                                          SizedBox(height: 24),
                                                          CustomButton(
                                                            text: "Update",
                                                            onPressed:
                                                                () async {
                                                              isLoading = true;
                                                              setState(() {});
                                                              bool result = await profileViewModel
                                                                  .updateUserName(
                                                                      nameController
                                                                          .text
                                                                          .trim());
                                                              isLoading = false;
                                                              setState(() {});
                                                              if (result) {
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            },
                                                            disabled: isLoading ||
                                                                nameController
                                                                    .text
                                                                    .trim()
                                                                    .isEmpty,
                                                          ),
                                                          SizedBox(height: 24),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.edit, size: 18),
                                            color: AppColors.white,
                                          )
                                        ],
                                      ),
                                      if (User().email != null) ...[
                                        CustomTextField(
                                          text: User().email!,
                                          color: AppColors.white,
                                          styleFace:
                                              CustomTextStyles.sb15.white,
                                        ),
                                        SizedBox(height: 4),
                                      ],
                                      if (User().phone != null) ...[
                                        CustomTextField(
                                          text: User().phone!,
                                          color: AppColors.white,
                                          styleFace:
                                              CustomTextStyles.sb15.white,
                                        ),
                                        SizedBox(height: 4),
                                      ],
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        launchUrl("https://google.in/");
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 5, 0, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.file_present_outlined,
                              color: AppColors.black,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            CustomTextField(
                              text: "Terms & Conditions",
                              upperCase: false,
                              styleFace: CustomTextStyles.thickb14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl("https://google.in/");
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 5, 0, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppColors.black,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            CustomTextField(
                              text: "Privacy Policy",
                              upperCase: false,
                              styleFace: CustomTextStyles.thickb14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl("https://google.in/");
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 5, 0, 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.help_outline,
                              color: AppColors.black,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            CustomTextField(
                              text: "FAQs",
                              upperCase: false,
                              styleFace: CustomTextStyles.thickb14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.grey,
                    ),
                    GestureDetector(
                      onTap: () {
                        // controller.logout();
                        _showLogoutBottomSheet(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  text: "Logout",
                                  styleFace: CustomTextStyles.b13.red,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomTextField(
                                  text: "Logoff your session",
                                  upperCase: false,
                                  styleFace: CustomTextStyles.r11.subtitle,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 16),
              Text(
                'Are you sure you want to logout ?',
                style: CustomTextStyles.r14,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Action for the "No" button
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppColors.primary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                      child: CustomTextField(
                        text: "No",
                        upperCase: false,
                        styleFace: CustomTextStyles.r14.primary,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Action for the "Yes" button
                      profileViewModel.logout();
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.login_with_otp,
                          (Route<dynamic> route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                      child: CustomTextField(
                        text: "Yes",
                        upperCase: false,
                        styleFace: CustomTextStyles.r14.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void capturePng() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    if (boundary.debugNeedsPaint) {
      Timer(Duration(seconds: 2), () => capturePng());
      return null;
    }
    final directory = (await getExternalStorageDirectory())?.path;

    final ui.Image image = await boundary.toImage();

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List pngBytes = byteData?.buffer.asUint8List() as Uint8List;
    File imgFile = File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes);
    /* final RenderBox box =
        globalKey.currentContext?.findRenderObject() as RenderBox;
    Share.shareFiles(['$directory/screenshot.png'],
        subject: 'Share ScreenShot',
        text: 'Please find my visiting card',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);*/
  }

  launchUrl(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  void _openLanugageBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  //could change this to Color(0xFF737373),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                    child: Container(
                        child: Opacity(
                      opacity: 0.7,
                      child: CustomTextField(
                        text: "Choose Language",
                      ),
                    )),
                  ),
                  getLanguageCard("English", context),
                  getLanguageCard("हिंदी", context),
                ],
              ),
            ),
          );
        });
  }

  Widget getLanguageCard(cardItem, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CustomTextField(
                  text: cardItem,
                  upperCase: false,
                )),
          ),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.check,
                color: AppColors.primary,
              )),
        ],
      ),
    );
  }
}
