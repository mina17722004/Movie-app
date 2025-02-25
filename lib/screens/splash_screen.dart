import 'package:flutter/material.dart';

import '../theme/app_assets.dart';
import '../theme/app_colors.dart';
import 'onBoarding/onboarding_one.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName="splashScreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds and then navigate to the home screen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => onBoardingOne()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.black,
      // Match the splash screen background color
      body: Column(
        children: [
          SizedBox(height: 300,),
          Center(
            child: Image.asset(
                'assets/applogo.png'), // Match the splash screen image
          ),
          SizedBox(height: 200,),
          Image.asset(AppAssets.routeLogo),
          Text("Supervised by Mohamed Nabil",
            style: TextStyle(fontSize: 16, color: appColors.white),)
        ],
      ),

    );
  }
}