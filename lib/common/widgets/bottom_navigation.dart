// import 'package:flutter/material.dart';
// import 'package:flutter_architecture/common/styles/app_colors.dart';
// import 'package:flutter_architecture/common/styles/custom_text_styles.dart';
// import 'package:flutter_architecture/common/utilities/constants.dart';
//
// import 'text_widget.dart';
//
// class BottomNavigationBarView extends StatelessWidget {
//   final String selected; // Declare the parameter as an instance variable
//   final VoidCallback onHomePressed;
//   final VoidCallback onTicketPressed;
//   final VoidCallback onWalletPressed;
//   final VoidCallback onRechargePressed;
//
//   const BottomNavigationBarView({
//     super.key,
//     required this.selected,
//     required this.onHomePressed,
//     required this.onTicketPressed,
//     required this.onWalletPressed,
//     required this.onRechargePressed,
//   }); //
//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       child: Container(
//         height: 60.0,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             GestureDetector(
//               onTap: onHomePressed,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Stack(
//                       children: [
//                         Image.asset(
//                           "assets/imgs/plan.png",
//                           height: 25,
//                           color: isSelected(AppConstants.PLAN)
//                               ? AppColors.primary
//                               : AppColors.black,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     CustomTextField(
//                         text: AppConstants.PLAN,
//                         styleFace: isSelected(AppConstants.PLAN)
//                             ? CustomTextStyles.selectedBottomNav
//                             : CustomTextStyles.bottomNavText)
//                   ],
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: onTicketPressed,
//               child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Image.asset(
//                         "assets/imgs/study.png",
//                         height: 25,
//                         color: isSelected(AppConstants.STUDY)
//                             ? AppColors.primary
//                             : AppColors.black,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       CustomTextField(
//                           text: AppConstants.STUDY,
//                           styleFace: isSelected(AppConstants.STUDY)
//                               ? CustomTextStyles.selectedBottomNav
//                               : CustomTextStyles.bottomNavText)
//                     ],
//                   )),
//             ),
//             GestureDetector(
//               onTap: onWalletPressed,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       "assets/imgs/test.png",
//                       height: 25,
//                       color: isSelected(AppConstants.TEST)
//                           ? AppColors.primary
//                           : AppColors.black,
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     CustomTextField(
//                         text: AppConstants.TEST,
//                         styleFace: isSelected(AppConstants.TEST)
//                             ? CustomTextStyles.selectedBottomNav
//                             : CustomTextStyles.bottomNavText)
//                   ],
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: onRechargePressed,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       "assets/imgs/watchout.png",
//                       height: 25,
//                       color: isSelected(AppConstants.TEST_ANALYSIS)
//                           ? AppColors.primary
//                           : AppColors.black,
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     CustomTextField(
//                         text: AppConstants.TEST_ANALYSIS,
//                         styleFace: isSelected(AppConstants.TEST_ANALYSIS)
//                             ? CustomTextStyles.selectedBottomNav
//                             : CustomTextStyles.bottomNavText)
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   bool isSelected(String type) {
//     bool result = false;
//     if (selected == type) return true;
//     return result;
//   }
// }
