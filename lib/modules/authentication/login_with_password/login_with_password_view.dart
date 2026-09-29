// import 'package:flutter/material.dart';
// import 'package:flutter_architecture/common/routing/app_routes.dart';
// import 'package:flutter_architecture/common/widgets/text_widget.dart';
// import 'package:flutter_architecture/user_view_model.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../../../../common/styles/app_colors.dart';
// import '../../../../../common/styles/custom_text_styles.dart';
// import '../../../../../common/utilities/constants.dart';
// import '../../../../../common/widgets/custom_button.dart';
// import '../../../../../common/widgets/custom_text_form_field.dart';
//
// class LoginWithPasswordView extends StatefulWidget {
//   // LoginController loginController;
//   LoginWithPasswordView({Key? key}) : super(key: key);
//
//   @override
//   State<LoginWithPasswordView> createState() => _LoginWithPasswordViewState();
// }
//
// class _LoginWithPasswordViewState extends State<LoginWithPasswordView> {
//   final loginFormKey = GlobalKey<FormState>();
//
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<UserViewModel>(
//       builder: (context, userViewModel, _) {
//         return SafeArea(
//           child: Scaffold(
//             backgroundColor: AppColors.secondary2,
//             bottomNavigationBar: Padding(
//               padding: EdgeInsets.symmetric(vertical: 24),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   GestureDetector(
//                       onTap: () {
//                         Navigator.pushReplacementNamed(
//                             context, AppRoutes.login_with_otp);
//                       },
//                       child: CustomTextField(
//                           text: "Login with Mobile Number",
//                           styleFace: CustomTextStyles.b14.primary))
//                 ],
//               ),
//             ),
//             body: Container(
//               height: MediaQuery.of(context).size.height * .95,
//               color: AppColors.white,
//               padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: loginFormKey,
//                   child: Column(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
//                         alignment: Alignment.center,
//                         height: 80,
//                         width: 120,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(15.0),
//                           child: Image.asset(
//                             "assets/imgs/logo.png",
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       CustomTextField(
//                         text: "Flik Study",
//                         upperCase: false,
//                         styleFace: CustomTextStyles.medb35,
//                       ),
//                       SizedBox(height: 8),
//                       CustomTextField(
//                         text: "Your career bot",
//                         upperCase: false,
//                         styleFace: CustomTextStyles.medb35,
//                       ),
//                       SizedBox(height: 40),
//                       CustomTextFormField(
//                         labelText: 'Enter your email id',
//                         hintText: 'e.g. abc@xyz.com',
//                         controller: emailController,
//                         validator: validator,
//                         iconWidget: const Icon(Icons.person),
//                       ),
//                       CustomTextFormField(
//                         labelText: 'Enter your password',
//                         hintText: '********',
//                         controller: passwordController,
//                         validator: validator,
//                         iconWidget: const Icon(Icons.lock),
//                       ),
//                       SizedBox(height: 30),
//                       RichText(
//                         text: TextSpan(
//                           text: "By Continuing you accept ",
//                           style: CustomTextStyles.r12,
//                           children: <TextSpan>[
//                             TextSpan(
//                                 text: 'Terms & Conditions',
//                                 style: CustomTextStyles.r14.underline),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       CustomButton(
//                         text: userViewModel.loginLoadingStatus
//                             ? "Please wait ..."
//                             : 'Login',
//                         disabled:
//                             userViewModel.loginLoadingStatus ? true : false,
//                         onPressed: () async {
//                           await userViewModel.loginWithPassword(
//                               email: emailController.text.trim(),
//                               password: passwordController.text.trim());
//
//                           if (mounted && userViewModel.isLoggedIn) {
//                             Navigator.pushNamedAndRemoveUntil(
//                                 context,
//                                 AppRoutes.home,
//                                 (Route<dynamic> route) => false);
//                           }
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacementNamed(
//                               context, AppRoutes.register);
//                         },
//                         child: CustomTextField(
//                             text: "Don't have an account? Sign up",
//                             styleFace: CustomTextStyles.b14.primary),
//                       ),
//                       SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   String? validator(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please this field must be filled';
//     }
//     return null;
//   }
//
//   validateForm() {
//     var validated = false;
//     /*if(GetUtils.isEmail(emailController.text)){
//       validated=true;
//     }
//     else if(!GetUtils.isEmail(emailController.text)){
//       Get.snackbar("Error","Please enter valid Email",snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }
//     if(GetUtils.isLengthGreaterOrEqual(passwordController.text,6)){
//       validated=true;
//     }
//     else{
//       Get.snackbar("Error","Password should be at least 6 digit",snackPosition: SnackPosition.BOTTOM);
//       return false;
//     }*/
//     return validated;
//   }
//
//   loginUsers() async {
//     if (validateForm()) {
//       bool connectivity = await AppConstants.checkInternetConnectivity();
//       /*if(connectivity){
//         var response = await httpProvider.loginUser(
//             emailController.text, passwordController.text);
//         if (response != null && response?['auth'] == true) {
//
//           User user=User.fromJson(response);
//           _saveLoginDetails(user);
//
//
//         } else {
//           if(response!=null && response['msg']!=null)
//             Get.snackbar("Error",response?['msg'],snackPosition: SnackPosition.BOTTOM);
//         }
//       }else{
//         _fetchLocalUser();
//       }*/
//     }
//   }
//
//   launchUrl(String url) async {
//     var uri = Uri.parse(url);
//     if (await canLaunch(uri.toString())) {
//       await launch(uri.toString());
//     } else {
//       throw 'Could not launch ${uri.toString()}';
//     }
//   }
// }
