import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';

import '../styles/app_colors.dart';
import '../styles/custom_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final bool disabled;
  CustomButton(
      {required this.text,
      Color? color,
      required this.onPressed,
      this.disabled = false})
      : color = color ?? AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.0625,
        decoration: BoxDecoration(
          color: disabled
              ? AppColors.primaryDisabled
              : (color == null ? AppColors.primary : color),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: disabled
                ? AppColors.primaryDisabled
                : (color == null ? AppColors.primary : color),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: CustomTextField(
            text: text,
            upperCase: false,
            color: AppColors.white,
            styleFace: CustomTextStyles.r15.white,
          ),
        ));
  }
}
