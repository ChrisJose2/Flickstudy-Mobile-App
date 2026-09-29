import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/app_colors.dart';
import '../styles/custom_text_styles.dart';
import 'text_widget.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final bool boldFlag;
  final bool readOnly;
  final bool mandatory;
  final Icon? iconWidget;
  final Icon iconRightWidget;
  final bool iconRightWidgetFlag;
  final int maxLength;
  final int? maxLines;
  final int minLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final bool uppercase;
  final bool isRequiredLabel;

  CustomTextFormField({
    required this.labelText,
    this.hintText = "",
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.boldFlag = false,
    this.readOnly = false,
    this.iconWidget,
    this.iconRightWidget = const Icon(Icons.info),
    this.iconRightWidgetFlag = false,
    this.maxLength = 50,
    this.minLines = 1,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = null,
    this.onChanged,
    this.mandatory = false,
    this.uppercase = false,
    this.isRequiredLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: keyboardType != TextInputType.multiline
          ? (labelText == "" ? 50 : 80)
          : 115,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isRequiredLabel
              ? RichText(
                  text: TextSpan(
                      text: '$labelText',
                      style: mandatory
                          ? CustomTextStyles.medb14.red
                          : CustomTextStyles.r14,
                      children: [
                        TextSpan(
                            text: ' *',
                            style: mandatory
                                ? CustomTextStyles.medb12.red
                                : CustomTextStyles.maxb12)
                      ]),
                  // textScaleFactor: labelTextScale,
                  // maxLines: labelMaxLines,
                  // overflow: overflow,
                  // textAlign: textAlign,
                )
              : labelText != ""
                  ? CustomTextField(
                      text: labelText,
                      upperCase: uppercase,
                      styleFace: mandatory
                          ? CustomTextStyles.medb14.red
                          : CustomTextStyles.r14,
                    )
                  : Container(),
          labelText != "" ? SizedBox(height: 8) : Container(),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                    controller: controller,
                    validator: validator,
                    obscureText: obscureText,
                    readOnly: readOnly,
                    minLines: minLines,
                    maxLines: maxLines,
                    onChanged: onChanged,
                    maxLength: maxLength,
                    keyboardType: keyboardType,
                    inputFormatters: inputFormatters,
                    decoration: InputDecoration(
                      hintText: hintText,
                      prefixIcon: iconWidget != null ? iconWidget : null,
                      filled: true,
                      fillColor: AppColors.background,
                      counterText: '',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      // prefixIcon: iconWidget,
                      labelStyle: CustomTextStyles.r14,
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: AppColors.red)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: AppColors.background)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: AppColors.background)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: AppColors.background),
                      ),
                    )),
              ),
              /*iconRightWidgetFlag?GestureDetector(
                  onTap: onTapIcon,
                  child: iconRightWidget):Container()*/
            ],
          ),
        ],
      ),
    );
  }
}
