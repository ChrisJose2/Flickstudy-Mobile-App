import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/styles/app_colors.dart';
import 'package:flutter_architecture/common/styles/custom_text_styles.dart';

import 'text_widget.dart';

typedef MyCallback = void Function();

class AppBarQuestionsView extends StatelessWidget
    implements PreferredSizeWidget {
  final double progress;
  final VoidCallback onOverviewPressed;
  final VoidCallback onEndTestPressed;

  const AppBarQuestionsView({
    super.key,
    required this.progress,
    required this.onOverviewPressed,
    required this.onEndTestPressed,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppColors.appBarBackground,
        title: Row(children: [
          Expanded(
            child: LinearProgressIndicator(
              minHeight: 5,
              value: progress,
              backgroundColor: AppColors.grey,
              // valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 52,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: CustomTextField(
                text: "${(progress * 100).toStringAsFixed(0)} %",
                styleFace: CustomTextStyles.b16,
              ),
            ),
          ),
        ]),
        actions: [
          IconButton(
            onPressed: onOverviewPressed,
            icon: const Icon(Icons.apps, color: AppColors.black),
            tooltip: 'Overview',
          ),
          IconButton(
            onPressed: onEndTestPressed,
            icon: const Icon(Icons.close, color: AppColors.black),
            tooltip: 'End test',
          ),
        ],
        centerTitle: true);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
