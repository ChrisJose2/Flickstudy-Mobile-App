import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/common/routing/app_routes.dart';
import 'package:flutter_architecture/common/utilities/utils.dart';
import 'package:flutter_architecture/modules/user/user_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    try {
      checkUserLogin();
    } on Exception catch (e) {
      print(e);
      // TODO
    }
  }

  checkUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await Utilities.getUserSharedPrefs();
      await UserViewModel().checkStudentSubscription();
    } catch (ex) {
      print("Exception-----");
      print(ex);
    }

    if (prefs.containsKey("is_logged_in") &&
        prefs.getBool("is_logged_in") == true &&
        prefs.containsKey("id")) {
      if (UserViewModel().studentSubscription != null &&
          UserViewModel().studentSubscription!.data.isNotEmpty) {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.home, (Route<dynamic> route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.new_sub, (Route<dynamic> route) => false);
      }
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login_with_otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set the status bar and navigation bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    ));

    return Scaffold(
      backgroundColor: Colors.white, // Set your desired background color
      body: Center(
        child: Image.asset("assets/imgs/app_logo.jpeg",
            height: MediaQuery.of(context).size.height *
                0.25), // Replace with your splash screen content
      ),
    );
  }
}
