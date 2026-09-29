import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/modules/authentication/user_model.dart';
import 'package:flutter_architecture/modules/user/user_view_model.dart';
import 'package:provider/provider.dart';

import 'text_widget.dart';

typedef MyCallback = void Function();

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarBackground,
        iconTheme: IconThemeData(color: AppColors.black),
        title: Consumer<UserViewModel>(builder: (context, viewmodel, child) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.profile);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.0625,
                    width: MediaQuery.of(context).size.height * 0.0625,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset(
                          "assets/imgs/app_logo.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.profile);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          styleFace: CustomTextStyles.r14,
                          text: DateTime.now().hour < 12
                              ? "Good Morning,"
                              : DateTime.now().hour < 17
                                  ? "Good Afternoon,"
                                  : "Good Evening,",
                          upperCase: false,
                        ),
                        CustomTextField(
                          styleFace: CustomTextStyles.b16,
                          text: User().name,
                          upperCase: false,
                        ),
                      ],
                    ),
                  ),
                ),
                /*GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.notification_list);
                  },
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Stack(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: AppColors.primary,
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight2,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CustomTextField(
                                    text: "1",
                                    styleFace: CustomTextStyles.thickb8.primary,
                                  ))),
                        ],
                      )),
                ),*/
              ],
            ),
          );
        }),
        centerTitle: false);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
