import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/widgets/custom_button.dart';
import 'package:flutter_architecture/common/widgets/text_widget.dart';
import 'package:flutter_architecture/modules/user/user_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../common/styles/app_colors.dart';
import '../../../../../common/styles/custom_text_styles.dart';
import '../../../../../common/utilities/constants.dart';

class VerifyOTPView extends StatefulWidget {
  VerifyOTPView({Key? key}) : super(key: key);

  @override
  VerifyOTPViewState createState() => VerifyOTPViewState();
}

class VerifyOTPViewState extends State<VerifyOTPView> {
  // LoginController loginController;
  // LoginWithOTPView({Key? key}) : super(key: key);
  List<String> otpValues = List.filled(4, '');
  final loginFormKey = GlobalKey<FormState>();
  final mobileNumberController = TextEditingController();
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(otpValues.length, (index) => FocusNode());
  }

  String phone = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments != null) {
      phone = arguments as String;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, userViewModel, _) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Container(
              height: MediaQuery.of(context).size.height * .95,
              color: AppColors.white,
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
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
                      SizedBox(height: 40),
                      Container(
                        margin: EdgeInsets.fromLTRB(8, 0, 0, 10),
                        alignment: Alignment.centerLeft,
                        child: CustomTextField(
                            text: 'Enter OTP Sent on +91-$phone',
                            align: TextAlign.left),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          otpValues.length,
                          (index) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    otpValues[index] = value;
                                    validateForm();
                                    if (value.isNotEmpty &&
                                        index < otpValues.length - 1) {
                                      focusNodes[index + 1].requestFocus();
                                    } else if (value.isEmpty &&
                                        index < otpValues.length) {
                                      focusNodes[index - 1].requestFocus();
                                    }
                                    if (otpValues.join().length == 4) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    }
                                    setState(() {});
                                  });
                                },
                                focusNode: focusNodes[index],
                                maxLength: 1,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  counterText: '',
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 12.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: 20,
                            color: AppColors.white,
                            child: Center(
                              child: CustomTextField(
                                text: "Change Number",
                                upperCase: false,
                                styleFace: CustomTextStyles.r14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),
                      if (otpValues.join().length == 4)
                        CustomButton(
                          text: "Confirm",
                          onPressed: () async {
                            await userViewModel.verifyOTP(
                                phone: phone, otp: otpValues.join());
                            await UserViewModel().checkStudentSubscription();
                            if (UserViewModel().studentSubscription != null &&
                                UserViewModel()
                                    .studentSubscription!
                                    .data
                                    .isNotEmpty) {
                              if (mounted && userViewModel.isLoggedIn) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoutes.home,
                                    (Route<dynamic> route) => false);
                              }
                            } else {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.new_sub,
                                  (Route<dynamic> route) => false);
                            }
                          },
                          disabled: !validateForm(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter OTP";
    }
    return null;
  }

  validateForm() {
    var validated = false;
    String otp = otpValues.join();
    if (otp.length == otpValues.length) {
      validated = true;
    }
    return validated;
  }

  loginUsers() async {
    if (validateForm()) {
      bool connectivity = await AppConstants.checkInternetConnectivity();
      if (connectivity) {
        String otp = otpValues.join();
      }
    }
  }
}
