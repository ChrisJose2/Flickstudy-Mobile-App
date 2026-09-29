import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
import 'package:flutter_architecture/common/widgets/app_bar.dart';
import 'package:flutter_architecture/common/widgets/custom_button.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';

class ChooseCourseView extends StatefulWidget {
  @override
  ChooseCourseViewState createState() => ChooseCourseViewState();
}

class ChooseCourseViewState extends State<ChooseCourseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkGrey,
        appBar: AppBarView(),
        body: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(40),
                padding: const EdgeInsets.all(40),
                color: AppColors.white.withOpacity(0.2),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        text: "CAT Classic",
                        styleFace: CustomTextStyles.thickb25.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CustomTextField(
                            text: "Extensive ",
                            styleFace: CustomTextStyles.b14.primary,
                          ),
                          CustomTextField(
                            text: "course",
                            styleFace: CustomTextStyles.r14.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CustomTextField(
                            text: "Thorough ",
                            styleFace: CustomTextStyles.b14.primary,
                          ),
                          CustomTextField(
                            text: "preparation",
                            styleFace: CustomTextStyles.r14.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        text: "Rs. 22,000",
                        styleFace: CustomTextStyles.r14.white,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                          text: "Buy Now Rs. 15,000", onPressed: () {}),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CustomTextField(
                            text: "Course Benefits",
                            styleFace: CustomTextStyles.r14.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CustomTextField(
                            text: "Preview the course",
                            styleFace: CustomTextStyles.r14.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.video_camera_back_outlined,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                text: "500+ Videos",
                                styleFace: CustomTextStyles.b14.primary,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                text: "Concept Builders",
                                styleFace: CustomTextStyles.r14.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.video_camera_back_outlined,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                text: "500+ Videos",
                                styleFace: CustomTextStyles.b14.primary,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                text: "Concept Builders",
                                styleFace: CustomTextStyles.r14.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.video_camera_back_outlined,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                text: "500+ Videos",
                                styleFace: CustomTextStyles.b14.primary,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                text: "Concept Builders",
                                styleFace: CustomTextStyles.r14.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.video_camera_back_outlined,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                text: "500+ Videos",
                                styleFace: CustomTextStyles.b14.primary,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                text: "Concept Builders",
                                styleFace: CustomTextStyles.r14.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]))));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
