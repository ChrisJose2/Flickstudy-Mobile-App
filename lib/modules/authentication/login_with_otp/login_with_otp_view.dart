import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/widgets/custom_button.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/user/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../common/styles/app_colors.dart';
import '../../../../../common/styles/custom_text_styles.dart';
import '../../../../../common/widgets/custom_text_form_field.dart';

class LoginWithOTPView extends StatefulWidget {
  LoginWithOTPView({Key? key}) : super(key: key);

  @override
  State<LoginWithOTPView> createState() => _LoginWithOTPViewState();
}

class _LoginWithOTPViewState extends State<LoginWithOTPView> {
  final loginFormKey = GlobalKey<FormState>();

  final mobileNumberController = TextEditingController();

  bool validate() {
    return mobileNumberController.text.trim().length == 10;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, _) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.register);
              },
              child: Container(
                width: double.infinity,
                height: 40,
                child: CustomTextField(
                  text: "Don't have an account? Sign up",
                  styleFace: CustomTextStyles.b14.primary,
                  align: TextAlign.center,
                ),
              ),
            ),
            // bottomNavigationBar: Padding(
            //   padding: EdgeInsets.symmetric(vertical: 24),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       GestureDetector(
            //           onTap: () {
            //             Navigator.pushReplacementNamed(
            //                 context, AppRoutes.login);
            //           },
            //           child: CustomTextField(
            //               text: "Login with password",
            //               styleFace: CustomTextStyles.b14.primary))
            //     ],
            //   ),
            // ),
            body: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Container(
                color: AppColors.white,
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: loginFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
                          alignment: Alignment.center,
                          height: 80,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              "assets/imgs/logo.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        CustomTextField(
                          text: "Flick Study",
                          upperCase: false,
                          styleFace: CustomTextStyles.medb35,
                        ),
                        SizedBox(height: 8),
                        CustomTextField(
                          text: "Your career bot",
                          upperCase: false,
                          styleFace: CustomTextStyles.medb35,
                        ),
                        SizedBox(height: 60),
                        CustomTextFormField(
                          labelText: 'Enter your phone number',
                          hintText: 'e.g. 9876543210',
                          onChanged: (value) {
                            setState(() {});
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          controller: mobileNumberController,
                          validator: validator,
                          iconWidget: const Icon(Icons.person),
                        ),
                        SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            text: "By Continuing you accept ",
                            style: CustomTextStyles.r12,
                            children: [
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: CustomTextStyles.r14.underline,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    var uri = Uri.parse("https://wiom.in/");
                                    if (await canLaunch(uri.toString())) {
                                      await launch(uri.toString());
                                    } else {
                                      throw 'Could not launch ${uri.toString()}';
                                    }
                                  },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomButton(
                          text: userViewModel.loginLoadingStatus
                              ? "Please wait ..."
                              : 'Send OTP',
                          disabled:
                              userViewModel.loginLoadingStatus || !validate()
                                  ? true
                                  : false,
                          onPressed: () async {
                            if (mobileNumberController.text.trim().length ==
                                10) {
                              FocusManager.instance.primaryFocus?.unfocus();

                              bool isOTPSend = await userViewModel.loginWithOTP(
                                context: context,
                                phone: mobileNumberController.text.trim(),
                              );

                              if (mounted && isOTPSend) {
                                Navigator.pushNamed(
                                    context, AppRoutes.verify_otp,
                                    arguments:
                                        mobileNumberController.text.trim());
                              }
                            }
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please this field must be filled';
    }
    return null;
  }

  validateForm() {
    var validated = false;
    /*if(GetUtils.isEmail(emailController.text)){
      validated=true;
    }
    else if(!GetUtils.isEmail(emailController.text)){
      Get.snackbar("Error","Please enter valid Email",snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if(GetUtils.isLengthGreaterOrEqual(passwordController.text,6)){
      validated=true;
    }
    else{
      Get.snackbar("Error","Password should be at least 6 digit",snackPosition: SnackPosition.BOTTOM);
      return false;
    }*/
    return validated;
  }
}
