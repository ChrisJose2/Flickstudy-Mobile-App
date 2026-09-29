import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/custom_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final Color color;
  final bool boldFlag;
  final bool upperCase;
  final TextAlign align;
  final int? maxLines;
  final TextOverflow? overflow;
  final styleFace;

  CustomTextField(
      {required this.text,
      this.color = AppColors.white,
      this.boldFlag = false,
      this.styleFace = CustomTextStyles.r14,
      this.upperCase = false,
      this.maxLines,
      this.overflow,
      this.align = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    /*TextStyle style;
    if(styleFace==StylesFaces.BUTTON_STYLE){
      style=CustomTextStyles.buttonText;
    }else{
      style=boldFlag?CustomTextStyles.boldFormField:CustomTextStylesr14;
    }*/
    return Text(
      upperCase ? text.toUpperCase() : text,
      softWrap: true,
      textAlign: align,
      style: styleFace,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
