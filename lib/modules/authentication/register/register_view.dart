import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/user/user_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../common/styles/app_colors.dart';
import '../../../../../common/styles/custom_text_styles.dart';
import '../../../../../common/utilities/constants.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_text_form_field.dart';

class RegisterView extends StatefulWidget {
  // LoginController loginController;
  RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final loginFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final mobileController = TextEditingController();

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, userViewModel, _) {
      return Scaffold(
        backgroundColor: AppColors.white,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.login_with_otp);
                  },
                  child: CustomTextField(
                      text: "Already have an account? Login",
                      styleFace: CustomTextStyles.b14.primary))
            ],
          ),
        ),
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
                        margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
                        alignment: Alignment.center,
                        height: 80,
                        width: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            "assets/imgs/logo.png",
                            fit: BoxFit.cover,
                          ),
                        )),
                    CustomTextField(
                      text: "Flick Study",
                      upperCase: false,
                      styleFace: CustomTextStyles.medb35,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      text: "Create your account",
                      upperCase: false,
                      styleFace: CustomTextStyles.b18,
                    ),
                    SizedBox(height: 16),
                    CustomTextFormField(
                      labelText: 'Name',
                      isRequiredLabel: true,
                      controller: nameController,
                      validator: validator,
                      iconWidget: const Icon(Icons.person),
                      onChanged: (p0) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 16),
                    CustomTextFormField(
                      labelText: 'Phone Number',
                      isRequiredLabel: true,
                      controller: mobileController,
                      validator: validator,
                      maxLines: 1,
                      keyboardType: TextInputType.phone,
                      iconWidget: const Icon(Icons.phone_in_talk_rounded),
                      obscureText: false,
                      maxLength: 10,
                      onChanged: (p0) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 16),
                    CustomTextFormField(
                      labelText: 'Email Address',
                      isRequiredLabel: true,
                      controller: emailController,
                      validator: validator,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      iconWidget: const Icon(Icons.mail),
                      obscureText: false,
                      onChanged: (p0) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        launchUrl(
                            "https://foundation.wikimedia.org/wiki/Policy:Privacy_policy");
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "By continuing you accept ",
                          style: CustomTextStyles.r12,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Terms & Conditions',
                                style: CustomTextStyles.r12.underline),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      text: 'Create Profile',
                      disabled: nameController.text.isEmpty ||
                          mobileController.text.length < 10 ||
                          emailController.text.isEmpty,
                      onPressed: () async {
                        try {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await userViewModel.registerUser(
                              name: nameController.text,
                              email: emailController.text,
                              phone: mobileController.text);
                          if (mounted && userViewModel.isLoggedIn) {
                            await UserViewModel().checkStudentSubscription();
                            if (UserViewModel().studentSubscription != null &&
                                UserViewModel()
                                    .studentSubscription!
                                    .data
                                    .isNotEmpty) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.home,
                                  (Route<dynamic> route) => false);
                            } else {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.new_sub,
                                  (Route<dynamic> route) => false);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Failed to register user");
                          }
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: "Failed to register user");
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
      );
    });
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

  loginUsers() async {
    if (validateForm()) {
      bool connectivity = await AppConstants.checkInternetConnectivity();
      /*if(connectivity){
        var response = await httpProvider.loginUser(
            emailController.text, passwordController.text);
        if (response != null && response?['auth'] == true) {

          User user=User.fromJson(response);
          _saveLoginDetails(user);


        } else {
          if(response!=null && response['msg']!=null)
            Get.snackbar("Error",response?['msg'],snackPosition: SnackPosition.BOTTOM);
        }
      }else{
        _fetchLocalUser();
      }*/
    }
  }

  launchUrl(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
}
