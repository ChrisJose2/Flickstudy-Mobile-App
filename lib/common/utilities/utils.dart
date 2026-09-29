import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/main.dart';
import 'package:flutter_architecture/modules/authentication/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utilities {
  static Future<void> saveUserToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      await prefs.setString('id', User().id);
      await prefs.setString('sid', User().sid);
      await prefs.setString('name', User().name);
      if (User().email != null) {
        await prefs.setString('email', User().email!);
      }
      if (User().phone != null) {
        await prefs.setString('contactNo', User().phone!);
      }
      if (User().image != null) {
        await prefs.setString('image', User().image!);
      }
      if (User().roleId != null) {
        await prefs.setInt('roleId', User().roleId!);
      }
      if (User().status != null) {
        await prefs.setInt('status', User().status!);
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  static Future<void> getUserSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    User().id = prefs.getString('id') ?? '';
    User().sid = prefs.getString('sid') ?? '';
    User().name = prefs.getString('name') ?? '';
    User().email = prefs.getString('email');
    User().phone = prefs.getString('contactNo');
    User().image = prefs.getString('image');
    User().roleId = prefs.getInt('roleId');
    User().status = prefs.getInt('status');
  }

  static double textCardWidth(context) =>
      (MediaQuery.of(context).size.width - 40 - 20) / 3;
  static double imageCardWidth(context) =>
      ((MediaQuery.of(context).size.width - 40 - 10) / 3) * 2;

  // Responsive height helper - converts pixel height to screen-relative height
  static double responsiveHeight(BuildContext context, double height) {
    // Base height assumed to be 800 (typical mobile screen)
    // Adjust this base if needed for your design
    const double baseHeight = 800.0;
    final double screenHeight = MediaQuery.of(context).size.height;
    return (height / baseHeight) * screenHeight;
  }

  // Responsive width helper - converts pixel width to screen-relative width
  static double responsiveWidth(BuildContext context, double width) {
    // Base width assumed to be 360 (typical mobile screen)
    const double baseWidth = 360.0;
    final double screenWidth = MediaQuery.of(context).size.width;
    return (width / baseWidth) * screenWidth;
  }

  static Widget getCardWithImageText(String title, String image,
      [bool isNetworkImage = false]) {
    return Container(
      padding: EdgeInsets.all(12),
      width: (MediaQuery.of(navigatorKey.currentContext!).size.width - 60) / 3,
      height: ((MediaQuery.of(navigatorKey.currentContext!).size.width - 60) / 3) + 6,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(2, 2),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            child: isNetworkImage
                ? Image.network(image, height: MediaQuery.of(navigatorKey.currentContext!).size.height * 0.0375)
                : Image.asset(image, height: MediaQuery.of(navigatorKey.currentContext!).size.height * 0.0375),
          ),
          SizedBox(height: MediaQuery.of(navigatorKey.currentContext!).size.height * 0.015),
          Flexible(
            child: CustomTextField(
              text: title,
              styleFace: CustomTextStyles.r12,
              align: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  static Widget getCardWithCountAndText(
      String title, String image, String index) {
    return Container(
      padding: EdgeInsets.all(12),
      width: (MediaQuery.of(navigatorKey.currentContext!).size.width - 60) / 3,
      height: (MediaQuery.of(navigatorKey.currentContext!).size.width - 60) / 3,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(2, 2),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            text: index.toString(),
            styleFace: CustomTextStyles.thickb22.darkGrey,
          ),
          SizedBox(height: MediaQuery.of(navigatorKey.currentContext!).size.height * 0.00625),
          CustomTextField(
            text: title,
            styleFace: CustomTextStyles.r12,
            align: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
