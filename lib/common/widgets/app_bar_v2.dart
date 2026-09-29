import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';

import 'text_widget.dart';

typedef MyCallback = void Function();

class AppBarViewV2 extends StatelessWidget implements PreferredSizeWidget {
  String title;
  AppBarViewV2({required this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppColors.appBarBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.home, (Route<dynamic> route) => false);
            }
          },
        ),
        title: CustomTextField(
          text: title,
          styleFace: CustomTextStyles.b16,
        ),
        centerTitle: true);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
